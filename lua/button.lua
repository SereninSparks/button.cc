local Button = {}
Button.__index = Button

--- Create a new button
function Button.new(options)
    options = options or {}
    local button = setmetatable({}, Button)

    button.x = options.x or error("x position is required in button")
    button.y = options.y or error("y position is required in button")
    button.text = options.text or error("text is required in button")
    
    button.padding = options.padding or 1
	button.on_init = options.on_init or nil
    button.action = options.action or error("action is required in button")
    
    button.enabled = options.enabled and true or false
    button.enabled_text_color = options.enabled_text_color or colors.white
    button.disabled_text_color = options.disabled_text_color or colors.white
    button.enabled_background_color = options.enabled_background_color or colors.green
    button.disabled_background_color = options.disabled_background_color or colors.red

    button.initialized = false
	
    return button
end

--- Initialize the button instance
function Button:init()
    if self.initialized == false and type(self.on_init) == 'function' then
		self.on_init(self)
	end
	
	self.initialized = true
end

--- Resolve the button's text
function Button:get_text()
    local text = self.text

    if type(text) == 'function' then
        return text(self)
    end
    
    return text
end

--- Resolve the button's width
function Button:get_width()
    return #self:get_text() + (self.padding * 2)
end

--- Resolve the button's height
function Button:get_height()
    return 1 + (self.padding * 2)
end

--- Check if the button has been interacted with
function Button:was_touched(x, y)
    local start_x = self.x
    local end_x = self.x + self:get_width()
    local start_y = self.y
    local end_y = self.y + self:get_height()
    
    return x >= start_x and x < end_x and y > start_y and y <= end_y
end

--- Fire the button's action and toggle the enabled state
function Button:fire()
    self.enabled = not self.enabled
    self.action(self)
end

--- Fetch the button's colors based on its status
function Button:colors()
    if self.enabled then
        return self.enabled_text_color, self.enabled_background_color
    else
        return self.disabled_text_color, self.disabled_background_color
    end
end

return Button
