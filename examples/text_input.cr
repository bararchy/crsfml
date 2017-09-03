require "crsfml"


class TypingWidget < SF::Transformable
  include SF::Drawable

  @pinned_cur_pos : Float32? = nil

  def initialize(font : SF::Font, character_size : Int32)
    super()
    @cur_text = SF::Text.new("", font, character_size)
    @cur_text.color = SF::Color::Black
    @selection_color = SF::Color.new(0x3d, 0xae, 0xe9)
    @lines = [make_text("")] of SF::Text
    @y = 0
    @x = 0
    @cur_pos = 0.0f32
    @anchor = {0, 0}
    @anchor_pos = 0.0f32
    @cur_clock = SF::Clock.new
    update_cursor()
  end

  {% for attr in %w[font character_size color] %}
    {% attr = attr.id %}
    def {{attr}}
      @cur_text.{{attr}}.not_nil!
    end
    def {{attr}}=(value)
      @cur_text.{{attr}} = value
      @lines.each &.{{attr}} = value
      update_cursor()
    end
  {% end %}

  property selection_color

  private def line(i = @y)
    @lines[i].string
  rescue IndexError
    ""
  end

  private def set(s : String)
    @lines[@y].string = s
  end
  private def set(i : Int, s : String)
    @lines[i].string = s
  end
  private def set(r : Range, strings)
    @lines[r] = strings.map { |s| make_text(s) }
  end

  private def make_text(s : String)
    text = @cur_text.dup
    text.string = s
    text
  end

  private def cursor_pos(x)
    @cur_text.string = line[0...x]
    bounds = @cur_text.local_bounds
    bounds.left + bounds.width + 1
  end
  private def update_cursor(keep_anchor = false, reset_pin = true)
    @cur_pos = cursor_pos(@x)
    if reset_pin
      @pinned_cur_pos = nil
    end
    @cur_clock.restart
    unless keep_anchor
      @anchor = {@y, @x}
      @anchor_pos = @cur_pos
    end
  end

  private def delete_selection()
    a, b = [{@y, @x}, @anchor].sort!
    return false if a == b
    set a[0]..b[0], [line(a[0])[0...a[1]] + line(b[0])[b[1]..-1]]
    @y, @x = a
    update_cursor()
    true
  end

  def selecting?
    SF::Keyboard.key_pressed?(SF::Keyboard::LShift) || SF::Keyboard.key_pressed?(SF::Keyboard::RShift) ||
    SF::Mouse.button_pressed?(SF::Mouse::Left)
  end

  def left()
    if @x > 0
      @x -= 1
    elsif @y > 0
      @y -= 1
      @x = line.size
    end
    update_cursor(selecting?)
  end
  def right()
    if @x < line.size
      @x += 1
    elsif @y < @lines.size - 1
      @y += 1
      @x = 0
    end
    update_cursor(selecting?)
  end
  def up()
    if @y > 0
      go_line(@y - 1)
    else
      go_home()
    end
  end
  def down()
    if @y < @lines.size - 1
      go_line(@y + 1)
    else
      go_end()
    end
  end
  def go_home()
    @x = 0
    update_cursor(selecting?)
  end
  def go_end()
    @x = line.size
    update_cursor(selecting?)
  end
  def delete()
    return if delete_selection()
    if @x < line.size
      set line.sub(@x, "")
    elsif @y < @lines.size
      set @y..@y+1, [line(@y) + line(@y+1)]
    end
    update_cursor()
  end
  def backspace()
    return if delete_selection()
    if @x > 0 || @y > 0
      left()
      delete()
    end
  end
  def newline()
    delete_selection()
    set @y..@y, [line[0...@x], line[@x..-1]]
    right()
    update_cursor()
  end

  def click(x, y)
    spacing = font.get_line_spacing(character_size)
    @pinned_cur_pos = x.to_f32
    go_line({0, {(y / spacing).to_i, @lines.size - 1}.min}.max)
  end

  # Go to the line `y`, preserving the current horizontal cursor position
  def go_line(@y)
    old_cur_pos = (@pinned_cur_pos ||= @cur_pos)
    # Find the cursor position in this line that is the closest to the previous one
    results = {} of Int32 => Float32
    (0..line.size).bsearch { |x|
      (results[x] = cursor_pos(x)) >= old_cur_pos
    }
    @x, @cur_pos = results.min_by { |(x, cur_pos)| (cur_pos - old_cur_pos).abs }
    update_cursor(selecting?, reset_pin: false)
  end

  def input(event : SF::Event)
    case event
    when SF::Event::KeyPressed
      case event.code
      when SF::Keyboard::Left
        left()
      when SF::Keyboard::Right
        right()
      when SF::Keyboard::Up
        up()
      when SF::Keyboard::Down
        down()
      when SF::Keyboard::Home
        go_home()
      when SF::Keyboard::End
        go_end()
      when SF::Keyboard::BackSpace
        backspace()
      when SF::Keyboard::Delete
        delete()
      when SF::Keyboard::Return
        newline()
      end
    when SF::Event::TextEntered
      if event.unicode >= ' '.ord && event.unicode != 0x7f  # control chars and delete
        delete_selection()
        set line[0...@x] + event.unicode.chr + line[@x..-1]
        @x += 1
        update_cursor()
      end
    when SF::Event::MouseButtonPressed
      click(event.x - position.x, event.y - position.y)
      update_cursor()
    when SF::Event::MouseMoved
      click(event.x - position.x, event.y - position.y) if SF::Mouse.button_pressed?(SF::Mouse::Left)
    end
  end

  def draw(target, states)
    states.transform *= transform

    rect = SF::RectangleShape.new()
    spacing = font.get_line_spacing(character_size)

    a, b = [{@y, @cur_pos}, {@anchor[0], @anchor_pos}].sort!
    if a != b
      quad = SF::VertexArray.new(SF::TriangleStrip, 4)
      (a[0]..b[0]).each do |y|
        y1 = y * spacing
        y2 = y1 + spacing
        x1 = (y == a[0] ? a[1] : 0)
        x2 = (y == b[0] ? b[1] : 100000)
        quad[0] = SF::Vertex.new({x1, y1}, @selection_color)
        quad[1] = SF::Vertex.new({x1, y2}, @selection_color)
        quad[2] = SF::Vertex.new({x2, y1}, @selection_color)
        quad[3] = SF::Vertex.new({x2, y2}, @selection_color)
        target.draw quad, states
      end
    end

    @lines.each_with_index do |line, i|
      line.position = {0, spacing*i}
      target.draw line, states
    end

    states.blend_mode = SF::BlendMode.new(SF::BlendMode::OneMinusDstColor, SF::BlendMode::Zero)
    if @cur_clock.elapsed_time.as_seconds % 1.0 < 0.5
      y1 = @y * spacing
      y2 = y1 + spacing
      target.draw [
        SF::Vertex.new({@cur_pos, y1}),
        SF::Vertex.new({@cur_pos, y2}),
        SF::Vertex.new({@cur_pos + 1, y1}),
        SF::Vertex.new({@cur_pos + 1, y2})
      ], SF::Lines, states
    end
  end
end

def main()  # A hack to allow the code above to be reused: `require` and override `main`
  window = SF::RenderWindow.new(SF::VideoMode.new(800, 600), "Typing")
  text = TypingWidget.new(SF::Font.from_file("resources/font/Cantarell-Regular.otf"), 24)

  while window.open?
    while event = window.poll_event
      case event
      when SF::Event::Closed
        window.close()
      else
        text.input(event)
      end
    end
    window.clear SF::Color::White
    window.draw text
    window.display()
  end
end

main()
