" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Show line numbers
set number

" osx + linux
set clipboard=unnamed,unnamedplus

" set this higher for taller messages at bottom
set cmdheight=1

" don't look for autocompletions in included files (can be slow)
set complete-=i

" add an 80 char bg highlight
set colorcolumn=80

" dont replace long last lines with '@'
set display+=lastline

" default file encoding
set encoding=utf-8
set fileencodings+=utf-8

" let cursor keys work in insert mode
set esckeys

" converts tab chars to spaces
set expandtab

" Detect newline chars from more OSs
set fileformats+=mac

" Delete comment character when joining commented lines
" if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
" endif

" Keep a minimum of 1000 history items
if &history < 1000
    set history=1000
endif

" highlight all search matches
set hlsearch

" Smart caseing for searches
set ignorecase
set smartcase

" incremental searching
set incsearch

" Use <C-L> to clear the highlights of :set hlsearch
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" always show statusline
set laststatus=2

" use the more prompt when long messages displayed
set more

" enable the mouse for all modes
set mouse=a

" Hide column/row highlighting
set nocursorline
set nocursorcolumn

" hide the default "-- INSERT --" or "-- VISUAL --" from status line
set noshowmode

" dont wrap lines for display
set nowrap

" if vim tries to do math, it shouldnt do octal math
set nrformats-=octal

" width of the line numbers column
set numberwidth=4

" Set current dir to path, this let's us use `:find ...` to open files
set path=$PWD/**

" show line and column nums along with document percentage in the statusline
set ruler

" minimum number of lines/chars to show surrounding the cursor
set scrolloff=3
set sidescrolloff=5

" change from visual mode to selection mode when the mouse is used
set selectmode=mouse

" use short messages when possible
set shortmess=a

" show partial cmd in last line of screen
set showcmd

" tabs are equal to 4 spaces
set tabstop=4

" assume a fast terminal connection and smooth the drawing of chars
set ttyfast

" Use a dynamic list of options for auto-complete
set wildmenu

" set options for <C-n> or <C-p> auto-completion
set completeopt=menuone,longest,preview,noinsert

" set the characters that wrap at the end of a line
set whichwrap+=<,>,h,l,[,],s,b

" tell vim we are working with a dark bg
set background=dark

" tell vim that our terminal can handle 256 colors
" Also make sure that $TERM is one of xterm-256color or screen-256color
set t_Co=256

" Reset the "BCE" aka "Background Color Erase" behavior
set t_ut=

" =============================================================================
" Custom Mappings
" =============================================================================

" eff those new lines
nnoremap <leader>ftnl :%s/#012/\r/ge<CR>

" wrap lines at 100 chars
nnoremap <leader>wrap :%!fold -w 80<CR>

if has('persistent_undo')
    " save undo histories in central location
    set undodir=$HOME/.vim/undo
    " save 1000 undo operations
    set undolevels=1000
    " save undo operations on file close
    set undofile
endif

" Don't bother saving buffers / registers on restart
set viminfo=

" aliases for typos
:command -bang WQ wq<bang>
:command -bang Wq wq<bang>
:command -bang W w<bang>
:command -bang Q quit<bang>

" =============================================================================
" Marker - TODO
" =============================================================================

" TODO
colorscheme Tomorrow-Night-Bright

" " TODO play with indentatino settings
" " when starting a new line, mimic the indentation from the previous line
" set autoindent
" set nosmartindent
" set smarttab " intelligently handle tab chars
" set softtabstop=4
" set shiftwidth=4 " default number of spaces to insert for indentation
"
" "this is for airline
" set ttimeoutlen=50
"
" let g:airline_theme='tomorrow'
"
" "transparency behind line numbers
" highlight LineNr ctermbg=NONE
"
" let g:khuno_ignore="E128,E501"
" highlight SpellBad term=standout ctermfg=white term=underline cterm=underline
"
" " if the current path matches a regex listed below, khuno will turn itself off
" let khuno_exclusions= [
"   \ 'site-packages',]
"
" autocmd FileType python call s:OpenKhuno(khuno_exclusions)
" function! s:OpenKhuno(exclusion_patterns)
"     let current_path = expand("%:p:h")
"     for pattern in a:exclusion_patterns
"         let pattern = '\v(.*)' . pattern . '(.*)'
"         if current_path =~ pattern
"             exe ':Khuno off'
"             return
"         endif
"     endfor
" endfunction
"
"
" " set 2 space tabs for the following filetypes
" autocmd FileType ruby,haml,eruby,yaml,sass,cucumber,javascript,html set ai sw=2 sts=2 et
"
" " Modify syntax highlighting for file extensions
" autocmd BufNewFile,BufRead *.json setlocal ft=javascript
" autocmd BufNewFile,BufRead *.zsh-theme setlocal ft=zsh
" autocmd BufNewFile,BufRead {Gemfile,VagrantFile,*.pp} set ft=ruby
" autocmd BufNewFile,BufRead *.pyx setlocal ft=python
" autocmd BufNewFile,BufRead {*.conf.mac,*.conf.linux} set ft=conf
"
" " Go uses tabs not spaces
" autocmd FileType go setlocal noexpandtab
"
" " disable folding for reStructured Text (riv.vim)
" let g:riv_disable_folding=1
"
" " highlight trailing whitespace in any filetype
" hi ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
"
" " unicode is fun
" let g:airline_powerline_fonts = 1
"
" " gist-vim githubenterprise host
" let g:gist_api_url = 'https://github.atl.pdrop.net/api/v3'
" " gist-vim detect filetype from filename
" let g:gist_detect_filetype = 1
" " private by default
" let g:gist_post_private = 1
