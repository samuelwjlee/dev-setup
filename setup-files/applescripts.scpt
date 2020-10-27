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

on toggle_trello_todoist_calendar()
  set isTrelloRunning to application "Trello" is running
  set isTodoistRunning to application "Todoist" is running
  set isCalendarRunning to application "Calendar" is running

  if isTrelloRunning and isTodoistRunning and isCalendarRunning then
    tell application "Trello" to quit
    tell application "Todoist" to quit
    tell application "Calendar" to quit

    return "Quit Trello, Todoist and Calendar"
  else
    tell application "Trello" to activate
    tell application "Todoist" to activate
    tell application "Calendar" to activate

    return "Activate Trello,Todoist and Calendar"
  end if
end toggle_trello_todoist_calendar

on toggle_mail_messages()
  set isMailRunning to application "Mail.application" is running
  set isMessagesRunning to application "Messages" is running

  if isMailRunning and isMessagesRunning then
    tell application "Mail.application" to quit
    tell application "Messages" to quit

    return "Quit Mail and Messages"
  else
	tell application "Mail.application" to activate
    tell application "Messages" to activate

    return "Activate Mail and Messages"
  end if
end toggle_mail_messages
