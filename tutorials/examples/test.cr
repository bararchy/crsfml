# Adapted from SFML Shader example
# https://github.com/SFML/SFML/blob/master/examples/shader/Shader.cpp

require "crsfml"

class Scene
  def initialize
    texture = SF::Texture.from_file("a.png")
    texture.repeated = true
    @sprite = SF::Sprite.new
    @sprite.texture = texture
    @sprite.texture_rect = SF.int_rect(0, 0, 800, 600)
  end

  def draw(window)
    window.clear SF::Color::Black
    window.draw(@sprite)
  end
end

#context = SF::ContextSettings.new(0, 0, 0, 3, 2)
window = SF::RenderWindow.new(
  SF::VideoMode.new(800, 600), "SFML Shader",
  SF::Style::Titlebar | SF::Style::Close,
  #context
)
scene = Scene.new

while window.open?
  while event = window.poll_event
    case event
    when SF::Event::Closed
      window.close
    end
  end

  scene.draw(window)
  window.display
end
