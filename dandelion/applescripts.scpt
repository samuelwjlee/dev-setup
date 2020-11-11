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
  set allAppsRunning to application "Visual Studio Code" is running and application "Google Chrome" is running and application appName is running and application "Slack" is running
  set screenHeight to (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/{print $4}'")

  if application appName is not running then
    tell application appName
      activate
      set bounds of front window to {0, 0, 700, screenHeight}

      tell current session of current window
        # wait for Tunnelblick to connect
        delay 5

        write text "cdcw"
        write text "start"
        set commandTab to split horizontally with default profile

        tell commandTab
          write text "cdcw"
        end tell

      end tell
    end tell
  else if allAppsRunning
    (do shell script "kill_process_on_port 3000")
    tell application appName to quit

    # tells tunnelblick to quit
    return false
  end if

  tell application appName to set bounds of front window to {0, 0, 700, screenHeight}
  # tells tunnelblick to activate
  return true
end toggle_iterm

# set bounds func
on set_bounds()
  tell application "System Events" to tell process appName
    set screenWidth to (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/{print $2}'")
    set screenHeight to (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/{print $4}'")

    set position of window 1 to {0, 0}
    set size of window 1 to {screenWidth, screenHeight}
  end tell
end set_bounds
