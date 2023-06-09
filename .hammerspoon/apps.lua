local hyper = {'cmd', 'ctrl', 'shift', 'option'}

-- LAUNCH/FOCUS APPS

local appsModal = hs.hotkey.modal.new(hyper, 'o');

local apps = {
  { mod = '', key = "g", app = "Google Chrome" },
  { mod = '', key = "k", app = "Slack" },
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
