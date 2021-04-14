# script to toggle Tunnelblick

on toggle_vpn()
  tell application "Tunnelblick"
    set shouldSyncrhonizeDisconnect to application "Visual Studio Code" is running and application "Slack" is running and application "Google Chrome" is running
    set shouldOnlyDisconnectVPN to application "Visual Studio Code" is not running and application "Slack" is not running and application "Google Chrome" is not running

    set vpnState to get state of first configuration where name = "developers"

    if vpnState = "CONNECTED" and shouldSyncrhonizeDisconnect then
      disconnect all
    else if vpnState = "CONNECTED" and shouldOnlyDisconnectVPN then
      disconnect all
    else
      connect "developers"
    end if
  end tell
end toggle_vpn

# Generic func to toggle application
on toggle_app(appName)
  if application appName is running then
    tell application appName to quit
  else
    tell application appName to activate
  end if
end toggle_app

# set bounds func
on set_window_to_fullscreen(appName)
  tell application "System Events" to tell process appName
    set screenWidth to (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/{print $2}'")
    set screenHeight to (do shell script "system_profiler SPDisplaysDataType | awk '/Resolution/{print $4}'")

    set position of window 1 to {0, 0}
    set size of window 1 to {screenWidth, screenHeight}
  end tell
end set_window_to_fullscreen
