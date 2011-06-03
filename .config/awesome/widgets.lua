-- Awesome Widgets

--
-- Widgets
--
sep = widget({type="textbox"})
sep.text = " | "

dateicon = widget({type="imagebox"})
dateicon.image = image(beautiful.widget_bat)

baticon = widget({type = "imagebox" })
baticon.image = image(beautiful.widget_bat)

date_info = widget({type="textbox"})
bat_info = widget({type="textbox"})
vol_info = widget({type="textbox"})
wifi_info = widget({type="textbox"})

vicious.register(date_info, vicious.widgets.date, "<b>%b %d, %R </b>", 60) 
vicious.register(bat_info, vicious.widgets.bat, "$1$2%", 61, "BAT1")
vicious.register(vol_info, vicious.widgets.volume, 
					"vol $1%", 2, "Master")
vicious.register(wifi_info, vicious.widgets.wifi, 
					"${ssid} ${link}% ${rate} Mb/s", 5, "wlan0")

promptbox = awful.widget.prompt({ align = "left", prompt= "Run: " })
layoutbox = awful.widget.layoutbox()

-- List of tags (virtual screens)
taglist = {}
taglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, 
		function (tag) tag.selected = not tag.selected end),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)

taglist = awful.widget.taglist(1, 
	awful.widget.taglist.label.noempty, taglist.buttons)

-- List of windows
tasklist = {}
tasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
		if not c:isvisible() then
			awful.tag.viewonly(c:tags()[1])
		end
		client.focus = c
		c:raise()
	end),

	awful.button({ }, 3, function ()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ width=250 })
		end
    end),

	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
	end),

	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	end))

tasklist = awful.widget.tasklist(function(c)
		return awful.widget.tasklist.label.currenttags(c, 1)
    end, tasklist.buttons)

--
-- Top Panel
--
top_panel = awful.wibox({
	position = "top",
	height = 12,
	fg = beautiful.fg_normal,
	bg = beautiful.bg_normal,
	border_color = beautiful.border_widget,
	border_width = beautiful.border_width
})

-- R to L layout.
top_panel.widgets = { 
	promptbox,
	layoutbox,
	date_info,
	sep,
	wifi_info,
	sep,
	vol_info,
	sep,
	bat_info,
	taglist,
	tasklist,
	--systray,
	["layout"] = awful.widget.layout.horizontal.rightleft
}

-- I don't use more than one screen
top_panel.screen = 1

