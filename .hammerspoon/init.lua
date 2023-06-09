require("apps")

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
hs.grid.setMargins({6, 6});

-- hs.grid.MARGINX = 0
-- hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 6
hs.grid.GRIDHEIGHT = 2

-- Show grid
hs.hotkey.bind(hyper, 'g', function ()
  hs.grid.show();
end)

-- Center window on the screen
hs.hotkey.bind(hyper, 'c', function ()
  local win = hs.window.focusedWindow()
  win:centerOnScreen()
end)


local win_pos = {
  left = {x=0, y=0, w=3, h=2},
  left_thin = {x=0, y=0, w=2, h=2},
  left_wide = {x=0, y=0, w=4, h=2},

  -- Right when only one window
  right = {x=3, y=0, w=3, h=2},
  right_thin = {x=4, y=0, w=2, h=2},
  right_wide = {x=2, y=0, w=4, h=2},

  -- Right top when two windows
  right_top = {x=3, y=0, w=3, h=1},
  right_top_thin = {x=4, y=0, w=2, h=1},
  right_top_wide = {x=2, y=0, w=4, h=1},

  -- Right bottom when two windows
  right_bottom = {x=3, y=1, w=3, h=1},
  right_bottom_thin = {x=4, y=1, w=2, h=1},
  right_bottom_wide = {x=2, y=1, w=4, h=1},

  full = {x=0, y=0, w=6, h=2},
}

function compare_win_pos(a, b)
  if a.x ~= b.x then
    return false
  end
  if a.y ~= b.y then
    return false
  end
  if a.w ~= b.w then
    return false
  end
  if a.h ~= b.h then
    return false
  end
  return true
end

local no_tiling_apps = {
  'Activity Monitor',
  '1Password',
  'Notification Center',
  'System Settings',
  'Karabiner-Elements',
  'Updater',
  'SecurityAgent',
}

-- TODO: Save state of the tiling layout
hs.hotkey.bind(hyper, 'f', function ()
  local win = hs.window.focusedWindow()
  hs.grid.maximizeWindow(win)
end)

-------
-- New tiling system
-------

local visible_apps = {}

--------------------
-- Spaces watcher
--------------------

function init_visible_apps(id)
  local space_id = id

  if space_id == -1 then
    space_id = hs.spaces.focusedSpace()
  end

  if not visible_apps[space_id] then
    visible_apps[space_id] = {
      left_side = nil,
      right_side = {
        top = nil,
        bottom = nil,
      }
    }
  end
end

local spaces_watcher = hs.spaces.watcher.new(init_visible_apps)
spaces_watcher:start()

--------------------

local space_windows = hs.window.filter.defaultCurrentSpace
space_windows.forceRefreshOnSpaceChange = true

function handle_window_created(win)
  if not win then
    return
  end

  if win:subrole() == 'AXDialog' or win:subrole() == 'AXSystemDialog' then
    return
  end

  local space_id = hs.spaces.focusedSpace()
  local wins_in_space = visible_apps[space_id]

  if not wins_in_space then
    return
  end

  if wins_in_space.left_side and win == wins_in_space.left_side.win then
    return
  end
  if wins_in_space.right_side then
    if wins_in_space.right_side.top and win == wins_in_space.right_side.top.win then
      return
    end
    if wins_in_space.right_side.bottom and win == wins_in_space.right_side.bottom.win then
      return
    end
  end

  -- If no left window, assign it to the left
  if not wins_in_space.left_side then
    visible_apps[space_id].left_side = {
      win = win,
      cell = win_pos.full,
    }
    apply_win_positions(space_id)
    return
  end

  -- If left but not right, assign it to the right
  if not wins_in_space.right_side.top then
    -- Make left window to the left
    visible_apps[space_id].left_side.cell = win_pos.left

    -- Put app in right side
    visible_apps[space_id].right_side.top = {
      win = win,
      cell = win_pos.right,
    }

    apply_win_positions(space_id)
    return
  end

  if not wins_in_space.right_side.bottom then
    local right_top_cell = wins_in_space.right_side.top.cell
    local new_right_top_cell = right_top_cell
    local right_bottom_cell = nil

    if compare_win_pos(right_top_cell, win_pos.right) then
      new_right_top_cell = win_pos.right_top
      right_bottom_cell = win_pos.right_bottom
    elseif compare_win_pos(right_top_cell, win_pos.right_thin) then
      new_right_top_cell = win_pos.right_top_thin
      right_bottom_cell = win_pos.right_bottom_thin
    elseif compare_win_pos(right_top_cell, win_pos.right_wide) then
      new_right_top_cell = win_pos.right_top_wide
      right_bottom_cell = win_pos.right_bottom_wide
    end

    -- Update the top cell
    visible_apps[space_id].right_side.top.cell = new_right_top_cell

    -- Assign new win to the bottom
    visible_apps[space_id].right_side.bottom = {
      win = win,
      cell = right_bottom_cell,
    }

    apply_win_positions(space_id)
    return
  end
end

function handle_window_destroyed(win)
  if not win then
    return
  end

  if win:subrole() == 'AXDialog' or win:subrole() == 'AXSystemDialog' then
    return
  end

  local space_id = hs.spaces.focusedSpace()
  local wins_in_space = visible_apps[space_id]

  if not wins_in_space then
    return
  end

  -- If win is bottom right
  -- Clear bottom right
  -- Expand top right

  if wins_in_space.right_side.bottom and win == wins_in_space.right_side.bottom.win then
    visible_apps[space_id].right_side.bottom = nil

    local right_top_cell = wins_in_space.right_side.top.cell
    local new_right_top_cell = win_pos.right

    if compare_win_pos(right_top_cell, win_pos.right_top) then
      new_right_top_cell = win_pos.right
    elseif compare_win_pos(right_top_cell, win_pos.right_top_thin) then
      new_right_top_cell = win_pos.right_thin
    elseif compare_win_pos(right_top_cell, win_pos.right_top_wide) then
      new_right_top_cell = win_pos.right_wide
    end

    visible_apps[space_id].right_side.top.cell = new_right_top_cell
    apply_win_positions(space_id)
    return
  end

  -- If win is top right
  -- Clear top right
  -- If bottom right exists, expand it
  -- If not, expand left
  if wins_in_space.right_side.top and win == wins_in_space.right_side.top.win then
    visible_apps[space_id].right_side.top = nil

    if wins_in_space.right_side.bottom then
      local current_bottom_cell = wins_in_space.right_side.bottom.cell
      local new_bottom_cell = current_bottom_cell

      if compare_win_pos(current_bottom_cell, win_pos.right_bottom) then
        new_bottom_cell = win_pos.right
      elseif compare_win_pos(current_bottom_cell, win_pos.right_bottom_thin) then
        new_bottom_cell = win_pos.right_thin
      elseif compare_win_pos(current_bottom_cell, win_pos.right_bottom_wide) then
        new_bottom_cell = win_pos.right_wide
      end

      visible_apps[space_id].right_side.bottom.cell = new_bottom_cell

      -- Clear rigth bottom and assign it to right top
      visible_apps[space_id].right_side.top = visible_apps[space_id].right_side.bottom
      visible_apps[space_id].right_side.bottom = nil
    else
      visible_apps[space_id].left_side.cell = win_pos.full
      -- No wins to the right
      visible_apps[space_id].right_side.top = nil
      visible_apps[space_id].right_side.bottom = nil
    end

    apply_win_positions(space_id)
    return
  end

  -- If win is left
  -- Clear left
  -- If right top exists, make it left
  -- If right bottom exists, make it right top. Else, make the left full
  if wins_in_space.left_side and win == wins_in_space.left_side.win then
    local left_cell = wins_in_space.left_side.cell
    visible_apps[space_id].left_side = nil

    if wins_in_space.right_side.top then
      local right_top_cell = wins_in_space.right_side.top.cell

      visible_apps[space_id].left_side = wins_in_space.right_side.top
      visible_apps[space_id].left_side.cell = left_cell

      visible_apps[space_id].right_side.top = nil

      if wins_in_space.right_side.bottom then
        visible_apps[space_id].right_side.top = wins_in_space.right_side.bottom

        local new_right_top_cell = win_pos.right
        if compare_win_pos(right_top_cell, win_pos.right_top) then
          new_right_top_cell = win_pos.right
        elseif compare_win_pos(right_top_cell, win_pos.right_top_thin) then
          new_right_top_cell = win_pos.right_thin
        elseif compare_win_pos(right_top_cell, win_pos.right_top_wide) then
          new_right_top_cell = win_pos.right_wide
        end

        visible_apps[space_id].right_side.top.cell = new_right_top_cell
        visible_apps[space_id].right_side.bottom = nil
      else
        visible_apps[space_id].left_side.cell = win_pos.full
        visible_apps[space_id].right_side.top = nil
        visible_apps[space_id].right_side.bottom = nil
      end
    end

    apply_win_positions(space_id)
    return
  end
end

space_windows:subscribe(hs.window.filter.windowInCurrentSpace, handle_window_created)
space_windows:subscribe(hs.window.filter.windowVisible, handle_window_created)
space_windows:subscribe(hs.window.filter.windowUnfullscreened, handle_window_created)
space_windows:subscribe(hs.window.filter.windowNotInCurrentSpace, handle_window_destroyed)
space_windows:subscribe(hs.window.filter.windowMinimized, handle_window_destroyed)

function apply_win_positions(space_id)
  local wins = visible_apps[space_id]

  if not wins then
    return
  end

  if not wins.left_side then
    return
  end

  local left = wins.left_side
  hs.grid.set(left.win, left.cell)

  if wins.right_side.top then
    hs.grid.set(wins.right_side.top.win, wins.right_side.top.cell)
  end

  if wins.right_side.bottom then
    hs.grid.set(wins.right_side.bottom.win, wins.right_side.bottom.cell)
  end
end

function init_tiling()
  local space_id = hs.spaces.focusedSpace()

  -- Init visible apps for this space
  visible_apps[space_id] = {
    left_side = nil,
    right_side = {
      top = nil,
      bottom = nil,
    }
  }

  -- Get all windows in this space ordered by focused last
  local all_windows = space_windows:setSortOrder(hs.window.filter.sortByFocusedLast):getWindows()

  -- No windows, do nothing
  if #all_windows == 0 then
    return
  end

  for i, win in ipairs(all_windows) do
    -- Only handle 3 windows
    if i > 3 then
      break
    end

    if i == 1 then
      local cell = win_pos.full
      if #all_windows > 1 then
        cell = win_pos.left
      end
      visible_apps[space_id].left_side = { win = win, cell = cell }
    end

    if i == 2 then
      local cell = win_pos.right
      if #all_windows > 2 then
        cell = win_pos.right_top
      end
      visible_apps[space_id].right_side.top = { win = win, cell = cell }
    end

    if i == 3 then
      visible_apps[space_id].right_side.bottom = { win = win, cell = win_pos.right_bottom }
    end
  end

  apply_win_positions(space_id)

  -- Focus left side
  if visible_apps[space_id].left_side then
    visible_apps[space_id].left_side.win:focus()
  end
end

init_tiling()

--------------------
---- Move focus between visible widows
--------------------

local focusModal = hs.hotkey.modal.new(hyper, 'w');

focusModal:bind('', 'h', function ()
  space_windows:focusWindowWest();
end)

focusModal:bind('', 'l', function ()
  space_windows:focusWindowEast();
end)

focusModal:bind('', 'k', function ()
  space_windows:focusWindowNorth()
end)

focusModal:bind('', 'j', function ()
  space_windows:focusWindowSouth()
end)

function focusModal:entered()
  hs.window.highlight.ui.overlay=true
  hs.window.highlight.ui.overlayColor={0,0,0,0.1}
  hs.window.highlight.ui.overlayStrokeColor={0,0,0,0.5}
  -- hs.window.highlight.ui.overlayStrokeWidth=5
  hs.window.highlight.ui.frameWidth = 10
  hs.window.highlight.ui.frameColor = {0,0.6,1,0.8}
  hs.window.highlight.start()
end

function focusModal:exited()
  hs.window.highlight.stop()
end

focusModal:bind('', 'escape', function()
  focusModal:exit()
end)

-----------------------------------------------------------------------------------

--------------------
---- Window resizing
--------------------

function resize_window_left()
  local space_id = hs.spaces.focusedSpace()
  local wins_in_space = visible_apps[space_id]

  if not wins_in_space or not wins_in_space.left_side or not wins_in_space.left_side.win then
    return
  end

  local win = wins_in_space.left_side.win

  -- if win is on the left, make it smaller
  if wins_in_space.left_side and wins_in_space.left_side.win == win then
    local left_cell = wins_in_space.left_side.cell

    if compare_win_pos(left_cell, win_pos.left_thin) then
      return
    end

    local new_left_cell = hs.fnutils.copy(left_cell)
    new_left_cell.w = new_left_cell.w - 1

    visible_apps[space_id].left_side.cell = new_left_cell

    if wins_in_space.right_side.top then
      local right_top_cell = wins_in_space.right_side.top.cell

      local new_right_top_cell = hs.fnutils.copy(right_top_cell)
      new_right_top_cell.w = new_right_top_cell.w + 1
      new_right_top_cell.x = new_right_top_cell.x - 1

      visible_apps[space_id].right_side.top.cell = new_right_top_cell
    end

    if wins_in_space.right_side.bottom then
      local right_bottom_cell = wins_in_space.right_side.bottom.cell

      local new_right_bottom_cell = hs.fnutils.copy(right_bottom_cell)
      new_right_bottom_cell.w = new_right_bottom_cell.w + 1
      new_right_bottom_cell.x = new_right_bottom_cell.x - 1

      visible_apps[space_id].right_side.bottom.cell = new_right_bottom_cell
    end

    apply_win_positions(space_id)
    return
  end
end

function resize_window_right()
  local space_id = hs.spaces.focusedSpace()
  local wins_in_space = visible_apps[space_id]

  if not wins_in_space or not wins_in_space.left_side or not wins_in_space.left_side.win then
    return
  end

  local win = wins_in_space.left_side.win

  -- if win is on the left, make it smaller
  if wins_in_space.left_side and wins_in_space.left_side.win == win then
    local left_cell = wins_in_space.left_side.cell

    if compare_win_pos(left_cell, win_pos.left_wide) then
      return
    end

    local new_left_cell = hs.fnutils.copy(left_cell)
    new_left_cell.w = new_left_cell.w + 1

    visible_apps[space_id].left_side.cell = new_left_cell

    if wins_in_space.right_side.top then
      local right_top_cell = wins_in_space.right_side.top.cell

      local new_right_top_cell = hs.fnutils.copy(right_top_cell)
      new_right_top_cell.w = new_right_top_cell.w - 1
      new_right_top_cell.x = new_right_top_cell.x + 1

      visible_apps[space_id].right_side.top.cell = new_right_top_cell
    end

    if wins_in_space.right_side.bottom then
      local right_bottom_cell = wins_in_space.right_side.bottom.cell

      local new_right_bottom_cell = hs.fnutils.copy(right_bottom_cell)
      new_right_bottom_cell.w = new_right_bottom_cell.w - 1
      new_right_bottom_cell.x = new_right_bottom_cell.x + 1

      visible_apps[space_id].right_side.bottom.cell = new_right_bottom_cell
    end

    apply_win_positions(space_id)
    return
  end
end

hs.hotkey.bind(hyper, 'Left', resize_window_left)
hs.hotkey.bind(hyper, 'Right', resize_window_right)
