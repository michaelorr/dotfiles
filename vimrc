" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
" `syntax enable`: preserve prior highlight settings
" `syntax on`: override prior highlight settings
syntax enable

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Show line numbers
set number

" use osx + linux system clipboards
set clipboard=unnamed,unnamedplus

" set this higher for taller messages at bottom
set cmdheight=1

" don't look for autocompletions in included files (can be slow)
set complete-=i

" add an 100 char bg highlight
set colorcolumn=100

" dont replace long last lines with '@'
set display+=lastline

" default file encoding
set encoding=utf-8
set fileencodings+=utf-8

" let arrow keys and other escape sequences work in insert mode
set esckeys

" Detect newline chars from more OSs
set fileformats+=mac

" if a file is modified outside vim and NOT modified inside, reread the file
set autoread

" Keep a minimum of 100 history items
if &history < 200
    set history=200
endif

" search upward in path for tags
" (semicolon has special meaning, see `:help 'path'`
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
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
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" always show statusline
set laststatus=2

" use the more prompt when long messages displayed
set more

" enable the mouse for all modes
set mouse=a

" Hide column/row highlighting
set cursorline
set nocursorcolumn

" show formatoptions in statusline
" TODO
" set statusline+=fo[%{&fo}]

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

" eff those new lines
nnoremap <leader>ftnl :%s/#012/\r/ge<CR>

" wrap lines at 100 chars
nnoremap <leader>wrap :%!fold -w 100<CR>

" fix trailing whitespace
nnoremap <Leader>ws :%s/\s\+$//e<cr>

if has('persistent_undo')
    " save undo histories in central location
    set undodir=$HOME/.vim/undo
    " save 100 undo operations
    set undolevels=100
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

set timeout timeoutlen=2000 ttimeoutlen=50

" https://github.com/chriskempson/tomorrow-theme
" colorscheme Tomorrow-Night-Bright

" https://github.com/tomasr/molokai
" colorscheme molokai
" let g:molokai_original = 1
" let g:rehash256 = 1

" https://github.com/sjl/badwolf
colorscheme badwolf
let g:badwolf_tabline = 2

" http://vim.wikia.com/wiki/Indenting_source_code
set autoindent nosmartindent
set softtabstop=4 tabstop=4 shiftwidth=4 expandtab smarttab

" =============================================================================
" Marker - TODO
" Khuno / Airline
" =============================================================================
"
" let g:airline_theme='tomorrow'
" unicode is fun
" let g:airline_powerline_fonts = 1

" let g:khuno_ignore="E128,E501"
" highlight SpellBad term=standout ctermfg=white term=underline cterm=underline

" set 2 space tabs for the following filetypes
autocmd FileType coffee,ruby,haml,eruby,yaml,sass,cucumber,javascript,html set ai sw=2 sts=2 et

" Modify syntax highlighting for file extensions
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
autocmd BufNewFile,BufRead *.zsh-theme setlocal ft=zsh
autocmd BufNewFile,BufRead {Gemfile,VagrantFile,*.pp} set ft=ruby
autocmd BufNewFile,BufRead *.pyx setlocal ft=python
autocmd BufNewFile,BufRead {*.conf.mac,*.conf.linux} set ft=conf
autocmd BufNewFile,BufRead Dockerfile.tmpl set ft=Dockerfile

" http://vi.stackexchange.com/questions/137/how-do-i-edit-crontab-files-with-vim-i-get-the-error-temp-file-must-be-edited
" crontab must be edited 'in place'
autocmd filetype crontab setlocal nobackup nowritebackup

" Go uses tabs not spaces
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4

" highlight trailing whitespace in any filetype
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" mattn/gist-vim
let g:gist_api_url = 'https://git.rsglab.com/api/v3'
let g:gist_detect_filetype = 1
let g:gist_post_private = 1

call plug#begin()
Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-airline/vim-airline'
call plug#end()

" see `:h formatoptions` or `:h fo-table` for more
" :verbose set fo?
"
" Delete comment character when joining commented lines
au FileType * setl formatoptions+=j
" Do not auto-wrap comments according to textwidth
au FileType * setl formatoptions-=c
" Do not auto-insert comment leader after hitting 'o' or 'O'
au FileType * setl formatoptions-=o
" Do auto-insert comment leader after hitting <Enter> in insert mode
au FileType * setl formatoptions+=r
" Allow re-wrap via gq
au FileType * setl formatoptions+=q


" vim:set ft=vim et sw=2:
