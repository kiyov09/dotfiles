-- Load Spoons
hs.loadSpoon("EmmyLua")

local hyper = {'cmd', 'ctrl', 'shift', 'option'}

-- RELOAD HAMMERSPOON CONFIG
hs.hotkey.bind(hyper, 'r', function()
  hs.reload()
  hs.notify.new({
    title="Hammerspoon",
    informativeText="Config reloaded!",
    autoWithdraw=true,
    withdrawAfter=2
  }):send()
end)

-- TOGGLE HAMMERSPOON CONSOLE
-- hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

-- ENABLE CLI ACCESS
hs.ipc.cliInstall()

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

hs.window.animationDuration = 0

hs.grid.setGrid("6x1");
hs.grid.setMargins({10, 10});

-- hs.grid.MARGINX = 0
-- hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 6
hs.grid.GRIDHEIGHT = 2

hs.hotkey.bind(hyper, 'g', function ()
  hs.grid.show();
end)

hs.hotkey.bind(hyper, 'c', function ()
  local win = hs.window.focusedWindow()
  win:centerOnScreen()

  redrawBorder()
end)

function moveToLeft(win, section)
  local cell = hs.grid.get(win)

  local width = 2
  if cell.x == 0 and cell.w == 6 then
    width = 3
  end

  if cell.w == 3 then
    width = 4
  elseif cell.w == 2 then
    width = 3
  end

  if cell.x ~= 0 then
    width = 3
  end

  if section then
    width = section
  end

  hs.grid.set(win, {x=0, y=0, w=width, h=2})

  -- Change the last window size
  local last_focused_window_width = 6 - width;
  local prevWin = last_focused_window();
  if (prevWin ~= nil) then
    hs.grid.set(prevWin, {x=width, y=0, w=last_focused_window_width, h=2})
  end

  redrawBorder()
end

hs.hotkey.bind(hyper, 'Left', function ()
  local win = hs.window.focusedWindow()
  moveToLeft(win)
end)

function moveToRight(win, section)
  -- local win = hs.window.focusedWindow()
  local cell = hs.grid.get(win)

  local width = 2
  local x = 4

  if cell.x == 0 then
    width = 3
    x = 3
  else
    if cell.w == 3 then
      width = 4
      x = 2
    elseif cell.w == 2 then
      width = 3
      x = 3
    end
  end

  if section then
    width = section
    x=3
  end

  hs.grid.set(win, {x=x, y=0, w=width, h=2})

  -- Change the last window size
  local prevWin = last_focused_window();
  if (prevWin ~= nil) then
    hs.grid.set(prevWin, {x=0, y=0, w=x, h=2})
  end

  redrawBorder()
end

hs.hotkey.bind(hyper, 'Right', function ()
  local win = hs.window.focusedWindow()
  moveToRight(win)
end)

hs.hotkey.bind(hyper, 'Up', function ()
  local win = hs.window.focusedWindow()
  local cell = hs.grid.get(win)

  win:moveOneScreenNorth()
  hs.grid.set(win, cell)

  redrawBorder()
end)

hs.hotkey.bind(hyper, 'Down', function ()
  local win = hs.window.focusedWindow()
  local cell = hs.grid.get(win)

  win:moveOneScreenSouth()
  hs.grid.set(win, cell)

  redrawBorder()
end)

hs.hotkey.bind(hyper, 'f', function ()
  local win = hs.window.focusedWindow()
  hs.grid.maximizeWindow(win)
  redrawBorder()
end)

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- Move focus between visible widows

local focusModal = hs.hotkey.modal.new(hyper, 'w');

focusModal:bind('', 'h', function ()
  local win = hs.window.filter.new():setCurrentSpace(true)
  if win == nil then
    return
  end
  win:focusWindowWest(nil, true, true)

  redrawBorder()
  -- focusModal:exit()
end)

focusModal:bind('', 'l', function ()
  local win = hs.window.filter.new():setCurrentSpace(true)
  if win == nil then
    return
  end
  win:focusWindowEast(nil, true, true);

  redrawBorder()
  -- focusModal:exit()
end)

focusModal:bind('', 'k', function ()
  local win = hs.window.filter.new():setCurrentSpace(true)
  if win == nil then
    return
  end
  win:focusWindowNorth(nil, true, true);

  redrawBorder()
  -- focusModal:exit()
end)

focusModal:bind('', 'j', function ()
  local win = hs.window.filter.new():setCurrentSpace(true)
  if win == nil then
    return
  end
  win:focusWindowSouth(nil, true, true);

  redrawBorder()
  -- focusModal:exit()
end)

focusModal:bind('', 'escape', function()
  hs.alert.show("Exiting focus modal")
  focusModal:exit()
end)


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------


function take_place_of_focused ()
  local win = hs.window.focusedWindow()
  local last_focused = last_focused_window()

  if last_focused == nil then
    hs.grid.maximizeWindow(win)
    redrawBorder()
    return
  end

  local cell = hs.grid.get(last_focused)
  hs.grid.set(win, cell)

  last_focused:application():hide()

  redrawBorder()
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- Draw a blue border around the active app

local global_border = nil

function redrawBorder()
  win = hs.window.focusedWindow()

  if win ~= nil then
    appName = win:application():name()

    if appName == 'Alfred' then
      global_border:hide()
      return
    end
    if appName == 'Control Center' then
      global_border:hide()
      return
    end

    top_left = win:topLeft()
    size = win:size()
    if global_border ~= nil then
      global_border:delete()
    end
    global_border = hs.drawing.rectangle(hs.geometry.rect(top_left['x'] - 5, top_left['y'] - 5, size['w'] + 10, size['h'] + 10))
    global_border:setStrokeColor({["red"]=0,["blue"]=1,["green"]=0.5,["alpha"]=1})
    global_border:setFill(false)
    global_border:setStrokeWidth(6)
    global_border:setRoundedRectRadii(10, 10)
    global_border:show()
  end
end

redrawBorder()

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------


-- Windows filter
local allwindows = hs.window.filter.new(nil)

-- Track last focused window
function last_focused_window()
  return allwindows:getWindows(hs.window.filter.sortByFocusedLast)[2]
end

function win_sorted_by_focused_last()
  return allwindows:getWindows(hs.window.filter.sortByFocusedLast)
end

-- Subscribe to events in the filter
allwindows:subscribe(hs.window.filter.windowCreated, function ()
  redrawBorder()
end)

allwindows:subscribe(hs.window.filter.windowRejected, function ()
  -- win_sorted_by_focused_last()[1]:focus()
  redrawBorder()
end)

allwindows:subscribe(hs.window.filter.windowFocused, function ()
  redrawBorder()
end)

allwindows:subscribe(hs.window.filter.windowUnfocused, function ()
  redrawBorder()
end)

allwindows:subscribe(hs.window.filter.windowHidden, function ()
  redrawBorder()
end)

allwindows:subscribe(hs.window.filter.windowUnhidden, function ()
  redrawBorder()
end)

allwindows:subscribe(hs.window.filter.windowOnScreen, function ()
  redrawBorder()
end)

allwindows:subscribe(hs.window.filter.windowDestroyed, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowMinimized, function () redrawBorder() end)
allwindows:subscribe(hs.window.filter.windowMoved, function () redrawBorder() end)


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

-- LAUNCH APPS

local appsModal = hs.hotkey.modal.new(hyper, 'o');

local apps = {
  { mod = '', key = "g", app = "Google Chrome" },
  { mod = '', key = "k", app = "Slack" },
  -- { mod = '', key = "t", app = "iTerm" },
  { mod = '', key = "t", app = "Wezterm" },
  { mod = '', key = "d", app = "Dash" },
  { mod = {'shift'}, key = "t", app = "Telegram" },
  { mod = '', key = "s", app = "Safari" },
  { mod = '', key = "n", app = "Notion" },
  { mod = '', key = "m", app = "Mail" }
}

for i, object in ipairs(apps) do
  appsModal:bind(object.mod, object.key, function()
    if object.app == 'iTerm' then
      result = hs.application.launchOrFocusByBundleID('com.googlecode.iterm2');
    else
      result = hs.application.launchOrFocus(object.app);
    end
    appsModal:exit()
  end)
end

appsModal:bind('', 'escape', function()
  appsModal:exit()
end)

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--------------------------------------------------------------------------------
