" iSlime2.vim - SLIME-like support for running Vim with iTerm2
" Maintainer:   Mat Schaffer <http://matschaffer.com>
" Version:      0.1

" Allows running arbitrary command with :ISlime2
command! -nargs=+ ISlime2 :call <SID>iTermSendNext("<args>")
command! ISlime2Rerun :call s:iTermRerun()
command! ISlime2UpEnter :call s:iTermSendNext("OA")

function! s:iTermRerun()
  if exists("g:islime2_last_command")
    call s:iTermSendNext(g:islime2_last_command)
  else
    echoerr "No previous command. Try running a test first (with <leader>ft). Or you can store a command with `ISlime2 my command`"
  endif
endfunction

let s:current_file=expand("<sfile>")
" Sends the passed command to the next iTerm2 panel using Cmd+]
function! s:iTermSendNext(command)
  if has("gui_running")
      let l:scpt = "/scripts/gui_run_command.scpt"
  else
      let l:scpt = "/scripts/run_command.scpt"
  endif
  let l:run_command = fnamemodify(s:current_file, ":p:h:h") . l:scpt
  let g:islime2_last_command = a:command
  call system("osascript " . l:run_command . " " . s:shellesc(a:command))
endfunction

function! s:shellesc(arg) abort
  return '"'.escape(a:arg, '"').'"'
endfunction
