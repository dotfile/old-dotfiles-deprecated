-- Awesome Widgets

--------------
-- Widgets
--------------
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

--taglist = awful.widget.taglist(1, awful.widget.taglist.filter.all, taglist.buttons)

--mytasklist = awful.widget.tasklist(awful.widget.tasklist.filter.currenttags, tasklist.buttons)
--systray = widget({ type = "systray", align = "right" })


taglist = {}
taglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
taglist = awful.widget.taglist(1, awful.widget.taglist.label.noempty, taglist.buttons)

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


--------------
-- Bar
--------------
mybar = awful.wibox({
	position = "top",
	height = 12,
	fg = beautiful.fg_normal,
	bg = beautiful.bg_normal,
	border_color = beautiful.border_widget,
	border_width = beautiful.border_width
})

-- R to L layout.
mybar.widgets = { 
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
mybar.screen = 1

-- XXX

-- {{{ Wibox
-- Create a textbox widget
mytextbox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = "<b><small> " .. awesome.release .. " </small></b>"

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu.new({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal },
                                        { "Debian", debian.menu.Debian_menu.Debian }
                                      }
                            })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
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

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { mylauncher,
                           mytaglist[s],
                           mytasklist[s],
                           mypromptbox[s],
                           mytextbox,
                           mylayoutbox[s],
                           s == 1 and mysystray or nil }
    mywibox[s].screen = s
end
-- }}}

