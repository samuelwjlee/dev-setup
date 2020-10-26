# script to toggle Tunnelblick

tell application "Tunnelblick"
  set vpnState to get state of first configuration where name = "hc-3"
  if vpnState = "CONNECTED" then
    disconnect all
  else
    connect "hc-3"
  end if
end tell
