" MIT License. Copyright (c) 2015 Michael Orr.
" vim: et ts=2 sts=2 sw=2

let s:spc = g:airline_symbols.space

function! airline#extensions#khuno#init(ext)
  call a:ext.add_statusline_func('airline#extensions#khuno#apply')
endfunction

function! airline#extensions#khuno#apply(...)
  if &filetype == "python"
    let w:airline_section_warning = get(w:, 'airline_section_warning', g:airline_section_warning)
    let w:airline_section_warning .= '%{airline#extensions#khuno#status()}'
  endif
endfunction

function! airline#extensions#khuno#status()
  let g:airline#extensions#khuno#num = khuno#Status()
  return g:airline#extensions#khuno#num == '' ? '' : s:spc.'ǩ'.g:airline#extensions#khuno#num
endfunction
