if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetPicaxeIndent(v:lnum)

setlocal indentkeys+=0e,0n,0t

setlocal autoindent

if exists("*GetPicaxeIndent")
  finish
endif

let s:label_rx = '^\s*[a-zA-Z][a-zA-Z0-9]\+:\s*$'

function! GetPicaxeIndent( line )

  let curline = getline(a:line)

  if curline =~ s:label_rx
    return 0
  endif

  let prevlabel = prevnonblank(a:line - 1)
  while prevlabel != 0 && !(getline(prevlabel) =~ s:label_rx)
    let prevlabel = prevnonblank(prevlabel - 1)
  endwhile

  let prevlnum = prevnonblank(a:line - 1)
  while prevlnum != 0 && getline(prevlnum) =~ s:label_rx
    let prevlnum = prevnonblank(prevlnum - 1)
  endwhile

  let ind = 0
  if prevlnum != 0
    let ind = indent(prevlnum)
  else
    if prevlabel != 0
      let ind = &sw
    else
      let ind = 0
    endif
  endif

  let prevline = getline(prevlnum)

  if prevline =~ '^\s*\<for\>' || prevline =~ '^\s*if\>.\+\<then\s*$'  || prevline =~ '^\s*else\s*$'
    let ind = ind + &sw
  endif

  if curline =~ '^\s*\(next\|endif\|else\)\s*$'
    let ind = ind - &sw
  endif

  let ind = max(0, ind)

  if ind == 0 && prevlabel != 0
    let ind = ind + &sw
  endif

  return ind

endfunction

