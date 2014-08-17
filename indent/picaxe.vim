if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetPicaxeIndent()

setlocal indentkeys+=0=:

setlocal autoindent

if exists("*GetPicaxeIndent")
  finish
endif

function! GetPicaxeIndent()
  " Find a non-blank line above the current line.
  let prevlnum = prevnonblank(v:lnum - 1)
  let curline = getline(v:lnum)

  if match(curline, '^\s*\<[a-zA-Z0-9]\+:') != -1 
    return 0
  endif

  while prevlnum != 0 && match(getline(prevlnum), '^\<[a-zA-Z0-9]\+:') != -1 
    let prevlnum = prevnonblank(prevlnum-1)
  endwhile

  " Hit the start of the file, use zero indent.
  if prevlnum == 0
    return &shiftwidth
  endif

  let ind = indent(prevlnum)
  let prevline = getline(prevlnum)

  if match(prevline, '^\s*\<for\>') != -1 || match(prevline, '^\s*\<if\>.\+\<then\>\s*$') != -1  || match(prevline, '^\s*\<else\>') != -1
    let ind = ind + &shiftwidth
  endif

  if match(curline, '^\s*\<next\>') != -1 || match(curline, '^\s*\<endif\>') != -1 || match(curline, '^\s*\<else\>') != -1 
    let ind = ind - &shiftwidth
  endif

  let ind = max(ind, 0)

  return ind

endfunction

