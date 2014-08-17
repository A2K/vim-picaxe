" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetPicaxeIndent()

" To make Vim call GetPicaxeIndent() when it finds '\s*end' or '\s*until'
" on the current line ('else' is default and includes 'elseif').
setlocal indentkeys+=0=:

setlocal autoindent

" Only define the function once.
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

  "if match(prevline, '^\s*\<if\>\s*.+\s*\<then\>') != -1 || match(prevline, '^\s*\<for\>') != -1 || match(prevline, '\^w+:') != -1
    "echo "indent increase"
    "return ind + &shiftwidth
  "endif

  return ind

  "let midx = match(prevline, '^\s*\%(for\>\|do\>\)')
  "let midx = match(prevline, '^\s*\%(if\>\|for\>\|while\>\|repeat\>\|else\>\|elseif\>\|do\>\|then\>\)')
  "if midx == -1
    "let midx = match(prevline, '{\s*$')
    "if midx == -1
      "let midx = match(prevline, '\<function\>\s*\%(\k\|[.:]\)\{-}\s*(')
    "endif
  "endif

  "if midx != -1
    "" Add 'shiftwidth' if what we found previously is not in a comment and
    "" an "end" or "until" is not present on the same line.
    "if synIDattr(synID(prevlnum, midx + 1, 1), "name") != "luaComment" && prevline !~ '\<end\>\|\<until\>'
      "let ind = ind + &shiftwidth
    "endif
  "endif

  "" Subtract a 'shiftwidth' on end, else (and elseif), until and '}'
  "" This is the part that requires 'indentkeys'.
  "let midx = match(getline(v:lnum), '^\s*\%(end\|else\|until\|}\)')
  "if midx != -1 && synIDattr(synID(v:lnum, midx + 1, 1), "name") != "luaComment"
    "let ind = ind - &shiftwidth
  "endif

  "return ind
endfunction

