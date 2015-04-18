require "./window_lib"

module SF
  extend self

  class Context
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    
    # Create a new context
    # 
    # This function activates the new context.
    # 
    # *Returns*: New Context object
    def initialize()
      @owned = true
      @this = CSFML.context_create()
    end
    
    # Destroy a context
    # 
    # *Arguments*:
    # 
    # * `context`: Context to destroy
    def finalize()
      CSFML.context_destroy(@this) if @owned
    end
    
    # Activate or deactivate explicitely a context
    # 
    # *Arguments*:
    # 
    # * `context`: Context object
    # * `active`: True to activate, False to deactivate
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.context_set_active(@this, active)
    end
    
end

  class Window
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
      result
    end
    def to_unsafe
      @this
    end
    
    # Construct a new window (with a UTF-32 title)
    # 
    # This function creates the window with the size and pixel
    # depth defined in `mode`. An optional style can be passed to
    # customize the look and behaviour of the window (borders,
    # title bar, resizable, closable, ...). If `style` contains
    # Fullscreen, then `mode` must be a valid video mode.
    # 
    # The fourth parameter is a pointer to a structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    # 
    # *Arguments*:
    # 
    # * `mode`: Video mode to use (defines the width, height and depth of the rendering area of the window)
    # * `title`: Title of the window (UTF-32)
    # * `style`: Window style
    # * `settings`: Additional settings for the underlying OpenGL context
    # 
    # *Returns*: A new Window object
    def initialize(mode: VideoMode, title: String, style: WindowStyle, settings)
      title = title.chars; title << '\0'
      if settings
        csettings = settings; psettings = pointerof(csettings)
      else
        psettings = nil
      end
      @owned = true
      @this = CSFML.window_create_unicode(mode, title, style, psettings)
    end
    
    # Construct a window from an existing control
    # 
    # Use this constructor if you want to create an OpenGL
    # rendering area into an already existing control.
    # 
    # The second parameter is a pointer to a structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    # 
    # *Arguments*:
    # 
    # * `handle`: Platform-specific handle of the control
    # * `settings`: Additional settings for the underlying OpenGL context
    # 
    # *Returns*: A new Window object
    def initialize(handle: WindowHandle, settings)
      if settings
        csettings = settings; psettings = pointerof(csettings)
      else
        psettings = nil
      end
      @owned = true
      @this = CSFML.window_create_from_handle(handle, psettings)
    end
    
    # Destroy a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window to destroy
    def finalize()
      CSFML.window_destroy(@this) if @owned
    end
    
    # Close a window and destroy all the attached resources
    # 
    # After calling this function, the Window object remains
    # valid, you must call Window_destroy to actually delete it.
    # All other functions such as Window_pollEvent or Window_display
    # will still work (i.e. you don't have to test Window_isOpen
    # every time), and will have no effect on closed windows.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    def close()
      CSFML.window_close(@this)
    end
    
    # Tell whether or not a window is opened
    # 
    # This function returns whether or not the window exists.
    # Note that a hidden window (Window_setVisible(False)) will return
    # True.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: True if the window is opened, False if it has been closed
    def open
      CSFML.window_is_open(@this) != 0
    end
    
    # Get the settings of the OpenGL context of a window
    # 
    # Note that these settings may be different from what was
    # passed to the Window_create function,
    # if one or more settings were not supported. In this case,
    # SFML chose the closest match.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: Structure containing the OpenGL context settings
    def settings
      CSFML.window_get_settings(@this)
    end
    
    # Pop the event on top of event queue, if any, and return it
    # 
    # This function is not blocking: if there's no pending event then
    # it will return false and leave `event` unmodified.
    # Note that more than one event may be present in the event queue,
    # thus you should always call this function in a loop
    # to make sure that you process every pending event.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `event`: Event to be returned
    # 
    # *Returns*: True if an event was returned, or False if the event queue was empty
    def poll_event(event: Event*)
      CSFML.window_poll_event(@this, event) != 0
    end
    
    # Wait for an event and return it
    # 
    # This function is blocking: if there's no pending event then
    # it will wait until an event is received.
    # After this function returns (and no error occured),
    # the `event` object is always valid and filled properly.
    # This function is typically used when you have a thread that
    # is dedicated to events handling: you want to make this thread
    # sleep as long as no new event is received.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `event`: Event to be returned
    # 
    # *Returns*: False if any error occured
    def wait_event(event: Event*)
      CSFML.window_wait_event(@this, event) != 0
    end
    
    # Get the position of a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: Position in pixels
    def position
      CSFML.window_get_position(@this)
    end
    
    # Change the position of a window on screen
    # 
    # This function only works for top-level windows
    # (i.e. it will be ignored for windows created from
    # the handle of a child window/control).
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `position`: New position of the window, in pixels
    def position=(position: Vector2i)
      CSFML.window_set_position(@this, position)
    end
    
    # Get the size of the rendering region of a window
    # 
    # The size doesn't include the titlebar and borders
    # of the window.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: Size in pixels
    def size
      CSFML.window_get_size(@this)
    end
    
    # Change the size of the rendering region of a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `size`: New size, in pixels
    def size=(size: Vector2i)
      CSFML.window_set_size(@this, size)
    end
    
    # Change the title of a window (with a UTF-32 string)
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `title`: New title
    def title=(title: String)
      title = title.chars; title << '\0'
      CSFML.window_set_unicode_title(@this, title)
    end
    
    # Change a window's icon
    # 
    # `pixels` must be an array of `width` x `height` pixels
    # in 32-bits RGBA format.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `width`: Icon's width, in pixels
    # * `height`: Icon's height, in pixels
    # * `pixels`: Pointer to the array of pixels in memory
    def set_icon(width: Int32, height: Int32, pixels)
      if pixels
        cpixels = pixels; ppixels = pointerof(cpixels)
      else
        ppixels = nil
      end
      CSFML.window_set_icon(@this, width, height, ppixels)
    end
    
    # Show or hide a window
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `visible`: True to show the window, False to hide it
    def visible=(visible: Bool)
      visible = visible ? 1 : 0
      CSFML.window_set_visible(@this, visible)
    end
    
    # Show or hide the mouse cursor
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `visible`: True to show, False to hide
    def mouse_cursor_visible=(visible: Bool)
      visible = visible ? 1 : 0
      CSFML.window_set_mouse_cursor_visible(@this, visible)
    end
    
    # Enable or disable vertical synchronization
    # 
    # Activating vertical synchronization will limit the number
    # of frames displayed to the refresh rate of the monitor.
    # This can avoid some visual artifacts, and limit the framerate
    # to a good value (but not constant across different computers).
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `enabled`: True to enable v-sync, False to deactivate
    def vertical_sync_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.window_set_vertical_sync_enabled(@this, enabled)
    end
    
    # Enable or disable automatic key-repeat
    # 
    # If key repeat is enabled, you will receive repeated
    # KeyPress events while keeping a key pressed. If it is disabled,
    # you will only get a single event when the key is pressed.
    # 
    # Key repeat is enabled by default.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `enabled`: True to enable, False to disable
    def key_repeat_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.window_set_key_repeat_enabled(@this, enabled)
    end
    
    # Activate or deactivate a window as the current target
    # for OpenGL rendering
    # 
    # A window is active only on the current thread, if you want to
    # make it active on another thread you have to deactivate it
    # on the previous thread first if it was active.
    # Only one window can be active on a thread at a time, thus
    # the window previously active (if any) automatically gets deactivated.
    # This is not to be confused with Window_requestFocus().
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `active`: True to activate, False to deactivate
    # 
    # *Returns*: True if operation was successful, False otherwise
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.window_set_active(@this, active) != 0
    end
    
    # Request the current window to be made the active
    # foreground window
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or mouse events.
    # If a window requests focus, it only hints to the operating
    # system, that it would like to be focused. The operating system
    # is free to deny the request.
    # This is not to be confused with Window_setActive().
    def request_focus()
      CSFML.window_request_focus(@this)
    end
    
    # Check whether the window has the input focus
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or most mouse
    # events.
    # 
    # *Returns*: True if window has focus, false otherwise
    def has_focus()
      CSFML.window_has_focus(@this) != 0
    end
    
    # Display on screen what has been rendered to the
    # window so far
    # 
    # This function is typically called after all OpenGL rendering
    # has been done for the current frame, in order to show
    # it on screen.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    def display()
      CSFML.window_display(@this)
    end
    
    # Limit the framerate to a maximum fixed frequency
    # 
    # If a limit is set, the window will use a small delay after
    # each call to Window_display to ensure that the current frame
    # lasted long enough to match the framerate limit.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `limit`: Framerate limit, in frames per seconds (use 0 to disable limit)
    def framerate_limit=(limit: Int32)
      CSFML.window_set_framerate_limit(@this, limit)
    end
    
    # Change the joystick threshold
    # 
    # The joystick threshold is the value below which
    # no JoyMoved event will be generated.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # * `threshold`: New threshold, in the range [0, 100]
    def joystick_threshold=(threshold)
      threshold = threshold.to_f32
      CSFML.window_set_joystick_threshold(@this, threshold)
    end
    
    # Get the OS-specific handle of the window
    # 
    # The type of the returned handle is WindowHandle,
    # which is a typedef to the handle type defined by the OS.
    # You shouldn't need to use this function, unless you have
    # very specific stuff to implement that SFML doesn't support,
    # or implement a temporary workaround until a bug is fixed.
    # 
    # *Arguments*:
    # 
    # * `window`: Window object
    # 
    # *Returns*: System handle of the window
    def system_handle
      CSFML.window_get_system_handle(@this)
    end
    
end

  alias JoystickIdentification = CSFML::JoystickIdentification

  # Axes supported by SFML joysticks
  alias JoystickAxis = CSFML::JoystickAxis

  # Key codes
  alias KeyCode = CSFML::KeyCode

  # Mouse buttons
  alias MouseButton = CSFML::MouseButton

  # Sensor Types
  alias SensorType = CSFML::SensorType

  # Definition of all the event types
  alias EventType = CSFML::EventType

  # Keyboard event parameters
  alias KeyEvent = CSFML::KeyEvent

  # Text event parameters
  alias TextEvent = CSFML::TextEvent

  # Mouse move event parameters
  alias MouseMoveEvent = CSFML::MouseMoveEvent

  # Mouse buttons events parameters
  alias MouseButtonEvent = CSFML::MouseButtonEvent

  # Mouse wheel events parameters
  alias MouseWheelEvent = CSFML::MouseWheelEvent

  # Joystick axis move event parameters
  alias JoystickMoveEvent = CSFML::JoystickMoveEvent

  # Joystick buttons events parameters
  alias JoystickButtonEvent = CSFML::JoystickButtonEvent

  # Joystick connection/disconnection event parameters
  alias JoystickConnectEvent = CSFML::JoystickConnectEvent

  # Size events parameters
  alias SizeEvent = CSFML::SizeEvent

  # Touch events parameters
  alias TouchEvent = CSFML::TouchEvent

  # Sensor event parameters
  alias SensorEvent = CSFML::SensorEvent

  # Event defines a system event and its parameters
  alias Event = CSFML::Event

  # VideoMode defines a video mode (width, height, bpp, frequency)
  # and provides functions for getting modes supported
  # by the display device
  alias VideoMode = CSFML::VideoMode

  # Enumeration of window creation styles
  alias WindowStyle = CSFML::WindowStyle

  # Structure defining the window's creation settings
  alias ContextSettings = CSFML::ContextSettings

  # Check if a joystick is connected
  # 
  # *Arguments*:
  # 
  # * `joystick`: Index of the joystick to check
  # 
  # *Returns*: True if the joystick is connected, False otherwise
  def joystick_is_connected(joystick: Int32)
    CSFML.joystick_is_connected(joystick) != 0
  end
  
  # Return the number of buttons supported by a joystick
  # 
  # If the joystick is not connected, this function returns 0.
  # 
  # *Arguments*:
  # 
  # * `joystick`: Index of the joystick
  # 
  # *Returns*: Number of buttons supported by the joystick
  def joystick_get_button_count(joystick: Int32)
    CSFML.joystick_get_button_count(joystick)
  end
  
  # Check if a joystick supports a given axis
  # 
  # If the joystick is not connected, this function returns false.
  # 
  # *Arguments*:
  # 
  # * `joystick`: Index of the joystick
  # * `axis`: Axis to check
  # 
  # *Returns*: True if the joystick supports the axis, False otherwise
  def joystick_has_axis(joystick: Int32, axis: JoystickAxis)
    CSFML.joystick_has_axis(joystick, axis) != 0
  end
  
  # Check if a joystick button is pressed
  # 
  # If the joystick is not connected, this function returns false.
  # 
  # *Arguments*:
  # 
  # * `joystick`: Index of the joystick
  # * `button`: Button to check
  # 
  # *Returns*: True if the button is pressed, False otherwise
  def joystick_is_button_pressed(joystick: Int32, button: Int32)
    CSFML.joystick_is_button_pressed(joystick, button) != 0
  end
  
  # Get the current position of a joystick axis
  # 
  # If the joystick is not connected, this function returns 0.
  # 
  # *Arguments*:
  # 
  # * `joystick`: Index of the joystick
  # * `axis`: Axis to check
  # 
  # *Returns*: Current position of the axis, in range [-100 .. 100]
  def joystick_get_axis_position(joystick: Int32, axis: JoystickAxis)
    CSFML.joystick_get_axis_position(joystick, axis)
  end
  
  # Get the joystick information
  # 
  # The result of this function will only remain valid until
  # the next time the function is called.
  # 
  # *Arguments*:
  # 
  # * `joystick`: Index of the joystick
  # 
  # *Returns*: Structure containing joystick information.
  def joystick_get_identification(joystick: Int32)
    CSFML.joystick_get_identification(joystick)
  end
  
  # Update the states of all joysticks
  # 
  # This function is used internally by SFML, so you normally
  # don't have to call it explicitely. However, you may need to
  # call it if you have no window yet (or no window at all):
  # in this case the joysticks states are not updated automatically.
  def joystick_update()
    CSFML.joystick_update()
  end
  
  # Check if a key is pressed
  # 
  # *Arguments*:
  # 
  # * `key`: Key to check
  # 
  # *Returns*: True if the key is pressed, False otherwise
  def keyboard_is_key_pressed(key: KeyCode)
    CSFML.keyboard_is_key_pressed(key) != 0
  end
  
  # Check if a mouse button is pressed
  # 
  # *Arguments*:
  # 
  # * `button`: Button to check
  # 
  # *Returns*: True if the button is pressed, False otherwise
  def mouse_is_button_pressed(button: MouseButton)
    CSFML.mouse_is_button_pressed(button) != 0
  end
  
  # Get the current position of the mouse
  # 
  # This function returns the current position of the mouse
  # cursor relative to the given window, or desktop if NULL is passed.
  # 
  # *Arguments*:
  # 
  # * `relative_to`: Reference window
  # 
  # *Returns*: Position of the mouse cursor, relative to the given window
  def mouse_get_position(relative_to: Window)
    CSFML.mouse_get_position(relative_to)
  end
  
  # Set the current position of the mouse
  # 
  # This function sets the current position of the mouse
  # cursor relative to the given window, or desktop if NULL is passed.
  # 
  # *Arguments*:
  # 
  # * `position`: New position of the mouse
  # * `relative_to`: Reference window
  def mouse_set_position(position: Vector2i, relative_to: Window)
    CSFML.mouse_set_position(position, relative_to)
  end
  
  # Check if a sensor is available on the underlying platform
  # 
  # *Arguments*:
  # 
  # * `sensor`: Sensor to check
  # 
  # *Returns*: True if the sensor is available, False otherwise
  def sensor_is_available(sensor: SensorType)
    CSFML.sensor_is_available(sensor) != 0
  end
  
  # Enable or disable a sensor
  # 
  # All sensors are disabled by default, to avoid consuming too
  # much battery power. Once a sensor is enabled, it starts
  # sending events of the corresponding type.
  # 
  # This function does nothing if the sensor is unavailable.
  # 
  # *Arguments*:
  # 
  # * `sensor`: Sensor to enable
  # * `enabled`: True to enable, False to disable
  def sensor_set_enabled(sensor: SensorType, enabled: Bool)
    enabled = enabled ? 1 : 0
    CSFML.sensor_set_enabled(sensor, enabled)
  end
  
  # Get the current sensor value
  # 
  # *Arguments*:
  # 
  # * `sensor`: Sensor to read
  # 
  # *Returns*: The current sensor value
  def sensor_get_value(sensor: SensorType)
    CSFML.sensor_get_value(sensor)
  end
  
  # Get the current desktop video mode
  # 
  # *Returns*: Current desktop video mode
  def video_mode_get_desktop_mode()
    CSFML.video_mode_get_desktop_mode()
  end
  
  # Retrieve all the video modes supported in fullscreen mode
  # 
  # When creating a fullscreen window, the video mode is restricted
  # to be compatible with what the graphics driver and monitor
  # support. This function returns the complete list of all video
  # modes that can be used in fullscreen mode.
  # The returned array is sorted from best to worst, so that
  # the first element will always give the best mode (higher
  # width, height and bits-per-pixel).
  # 
  # *Arguments*:
  # 
  # * `count`: Pointer to a variable that will be filled with the number of modes in the array
  # 
  # *Returns*: Pointer to an array containing all the supported fullscreen modes
  def video_mode_get_fullscreen_modes(count: Size_t*)
    CSFML.video_mode_get_fullscreen_modes(count)
  end
  
  # Tell whether or not a video mode is valid
  # 
  # The validity of video modes is only relevant when using
  # fullscreen windows; otherwise any video mode can be used
  # with no restriction.
  # 
  # *Arguments*:
  # 
  # * `mode`: Video mode
  # 
  # *Returns*: True if the video mode is valid for fullscreen mode
  def video_mode_is_valid(mode: VideoMode)
    CSFML.video_mode_is_valid(mode) != 0
  end
  
end