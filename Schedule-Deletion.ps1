### This is my current version.  It took 3 revisions to get it to this point.

# the first 3 lines are to set the time and date in which you want to deactivate the account.  Enter in the hours in military time, minutes, seconds,
# and choose the month and day.

$time = "HH:MM:SS"
$date = "YYYY-MM-DD"
$datetime = "$date $time"

# the next 2 lines are for entering the username and running the command against that username.  This should be an account in your AD environment.

$username = "John.Doe"
$command = "Disable-LocalUser -Name $username"

# This next part is where the action happens.  We are using the 'New-ScheduledTaskAction' cmdlet to create an action that runs the "powershell.exe"
# command with the '$command' argument.  The '$command' argument contains the Disable-LocalUser command that was passed as a string.
# The 'New-ScheduledTaskAction' cmdlet returns an array of 'CimInstance' objects which is the expected type for the '-Action' parameter of the
# 'Register-ScheduledTask' cmdlet.

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $command

Register-ScheduledTask -TaskName "Deactivate John Doe" -Trigger (New-ScheduledTaskTrigger -Once -At $datetime) -User "Adminaccounthere" -Action $action

