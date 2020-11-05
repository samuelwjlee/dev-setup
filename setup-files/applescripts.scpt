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
on toggle_iterm()
  set appName to "iTerm"
  set allAppsRunning to application "Visual Studio Code" is running and application "Google Chrome" is running and application appName is running

  if application appName is not running then
      tell application appName
        activate
        set bounds of front window to {0, 23, 650, 1440}
      end tell
  else if allAppsRunning
    tell application appName to quit

    # tells tunnelblick to quit
    return false
  end if

  # tells tunnelblick to activate
  return true
end toggle_iterm
