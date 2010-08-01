-- Hooks and Callbacks for Awesome
--

require("beautiful")

client.add_signal("unfocus", function (c)
	c.border_color = beautiful.border_normal 
	c.border_width = beautiful.border_width
end)

client.add_signal("focus", function (c)
	c.border_color = beautiful.border_focus
	c.border_width = beautiful.border_width
end)


