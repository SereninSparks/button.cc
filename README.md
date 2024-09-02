# Button.cc

A simple Button API for ComputerCraft monitors

## Installation (Manual)

Copy the `button.lua` file into the folder that corresponds to the computer within your world.

The location of the folder depends on the launcher.

For example, using the FTB launcher on Windows, your computers will be in `%LOCALAPPDATA%\.ftba\instances\<uuid>\saves\<save name>\computercraft\computers\<id>`. Open the instance folder through the FTB app to get there faster.

## Usage

This is assuming that the file is called `button.lua` and it's located in the computer's root folder.

Import the module using `require` and then start making buttons!

```lua
local Button = require("button")

local my_button = Button.new({
    -- Required options
    x = 1,
    y = 1,
    text = "Hello, world!",
    action = function (self)
        print("Hello, world!")
    end,

    -- Optional options (values are the defaults)
    padding = 1,
    on_init = nil,
    enabled = false,
    enabled_text_color = colors.white,
    disabled_text_color = colors.white,
    enabled_background_color = colors.green,
    disabled_background_color = colors.red,
})
```

### Drawing buttons

Currently, this module does not come with a way to draw buttons on a monitor. This will be added in the future. Until then, you can create your own drawing function or use the following one as an example:

```lua
function draw_button(button)
    -- Define the padding texts so the button text is aligned properly
    local y_padding = string.rep(" ", button:get_width())
    local x_padding = string.rep(" ", button.padding)
    
    -- Generate the button text
    local text = string.format("%s%s%s", x_padding, button:get_text(), x_padding)

    -- Define where to start drawing the button
    local start_x = button.x
    local start_y = button.y
    
    -- The lines of text that need to be drawn
    local lines = {}
    
    -- Prepare the lines that need to be drawn
    if button:get_height() > 1 then    
        for i = 0, button.padding / 2, 1 do
            table.insert(lines, y_padding)
        end
        
        table.insert(lines, text)
        
        for i = 0, button.padding / 2, 1 do
            table.insert(lines, y_padding)
        end
    else
        table.insert(lines, text)
    end
    
    -- Draw the lines
    for i, line in pairs(lines) do
        monitor.setCursorPos(start_x, start_y + i)
        local text_color, background_color = button:colors()
        draw_text(line, text_color, background_color)
    end
end

function draw_text(text, text_color, background_color)
    -- Keep track of the previous colors so we can restore them
    local original_text_color = monitor.getTextColor()
    local original_background_color = monitor.getBackgroundColor()
    
    -- Draw the text
    monitor.setTextColor(text_color)
    monitor.setBackgroundColor(background_color)
    monitor.write(text)

    -- Restore the colors
    monitor.setTextColor(original_text_color)
    monitor.setBackgroundColor(original_background_color)
end
```

## Todos

- [ ] Write proper installation guide
- [ ] Add types and improve documentation
- [ ] Add a `draw` method and a way to attach a monitor to draw on

