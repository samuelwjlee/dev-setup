# script to toggle Tunnelblick

on toggle_vpn()
	tell application "Tunnelblick"
		set vpnState to get state of first configuration where name = "hc-3"
		if vpnState = "CONNECTED" then
			disconnect all
			return "VPN disconnected"
		else
			connect "hc-3"
			return "VPN connected"
		end if
	end tell
end toggle_vpn

# Generic func to toggle application
on toggle_app()
  set appName to "APP_NAME"

  if application appName is running then
    tell application appName to quit
  else
    tell application appName to activate
  end if
end toggle_app

# func to open all work relevant apps and resize windows to prefered size and loc
on toggle_work_apps()
  if application "iTerm" is not running then
    tell application "iTerm"
      activate
      set bounds of front window to {0, 23, 650, 1440}
    end tell
	else
		tell application "iTerm" to quit
  end if

  if application "Visual Studio Code" is not running then
    tell application "Visual Studio Code" to activate
	else
		tell application "Visual Studio Code" to quit
  end if
end toggle_work_apps
