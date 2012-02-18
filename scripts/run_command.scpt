on runInNextPane(_command)
  tell application "iTerm"
    tell current terminal
      tell i term application "System Events" to keystroke "]" using command down
      tell current session
        write text _command
      end tell
      tell i term application "System Events" to keystroke "[" using command down
    end tell
  end tell
end runInNextPane

on run argv
  set _command to item 1 of argv
  runInNextPane(_command)
end run
