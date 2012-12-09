on runInNextPane(_command)
  tell application "iTerm"
    tell current terminal
      tell current session
        write text _command
      end tell
    end tell
  end tell
end runInNextPane

on run argv
  set _command to item 1 of argv
  runInNextPane(_command)
end run

