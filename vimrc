set nocp " disable compatability mode
syntax enable " syntax highlighting
filetype plugin indent on " detect filetypes and enable plugins and indentation

set autoindent " when starting a new line, mimic the indentation from the previous line
set autoread " if a file was changed outside vim but not changed inside vim, read it again
set backspace=indent,eol,start " make backspace in insert mode delete linebreaks like you would expect
set clipboard=unnamed " TODO
set cmdheight=2 " more room for displaying messages at the bottom
set complete-=i " modifies where vim looks for autocompletions
set colorcolumn=80 " add an 80 char bg highlight
set display+=lastline " dont replace long last lines with '@'
if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif
set esckeys " let cursor keys work in insert mode
set expandtab " converts tab chars to spaces

set fileformats+=mac

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif

if &history < 1000
    set history=1000
endif

set hlsearch " highlight all search matches
" Use <C-L> to clear the highlights of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set ignorecase " case-insensitive searches
set incsearch " incremental searching
set laststatus=2 " laststatus aka show a status line even when only one window shown
set more " use the more prompt when long messages displayed
set mouse=a " enable the mouse for all modes
set mousemodel=popup " set the mouse behaviors, see :help mousemodel for more
set noshowmode " hide the default "-- INSERT --" from the status line
set nowrap " dont wrap lines
set nrformats-=octal " if vim tries to do math, it shouldnt do octal math
set nu " show line numbers
set numberwidth=5 " width of the line numbers column
set ruler " show line and column nums along with document percentage in the statusline
set scrolloff=4 " minimum number of lines to show surrounding the cursor
set selectmode=mouse " select when using the mouse
set shiftwidth=4 " default number of spaces to insert for indentation
set shortmess=a " use short messages when possible
set showcmd
set showmatch " highlight matching braces
set sidescrolloff=5
set smarttab " intelligently handle tab chars
set softtabstop=4

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set tabstop=4
set title
set ttyfast " assume a fast terminal connection and smooth the drawing of chars

if !empty(&viminfo)
    set viminfo^=!
endif

set wildmenu
set whichwrap+=<,>,h,l,[,],s,b " which keys will wrap around lines in normal and visual mode

" aliases for typos
command WQ wq
command Wq wq
command W w
command Q q

"order matters here in this segment
let g:solarized_termtrans=1
set background=dark
set t_Co=256
colorscheme Tomorrow-Night-Bright
hi normal ctermfg=255 ctermbg=none

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

"this is for airline
set ttimeoutlen=50

let g:airline_theme='tomorrow'

"transparency behind line numbers
highlight LineNr ctermbg=NONE

"let g:khuno_max_line_length=110
let g:khuno_ignore="E128,E501"
"coloring for khuno errors
highlight SpellBad cterm=underline,bold ctermbg=darkgray


" if the current path matches a regex listed below, khuno will turn itself off
let khuno_exclusions= [
  \ 'site-packages',]

autocmd FileType python call s:OpenKhuno(khuno_exclusions)
function! s:OpenKhuno(exclusion_patterns)
    let current_path = expand("%:p:h")
    for pattern in a:exclusion_patterns
        let pattern = '\v(.*)' . pattern . '(.*)'
        if current_path =~ pattern
            exe ':Khuno off'
            return
        endif
    endfor
endfunction


" set 2 space tabs for the following filetypes
autocmd FileType ruby,haml,eruby,yaml,sass,cucumber,javascript,html set ai sw=2 sts=2 et

" highlight json as though it were JS
autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" the following extensions should be treated like ruby
autocmd BufNewFile,BufRead {Gemfile,VagrantFile,*.pp} set ft=ruby
