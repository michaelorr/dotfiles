set nocp
syntax on
syntax enable
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set binary
set clipboard=unnamedplus
set cmdheight=2
set esckeys
set expandtab
set hlsearch
set ignorecase
set incsearch
set ls=2
set more
set mouse=a
set mousemodel=extend
set mousefocus
set nowrap
set nu
set numberwidth=5
set ruler
set scrolloff=4
set shiftwidth=4
set shortmess=a
set showmatch
set noshowmode
set selectmode=mouse
set smartindent
set smarttab
set softtabstop=4
set tabstop=4
set title
set ttyfast
set whichwrap+=<,>,h,l,[,]

"i cant type good
command WQ wq
command Wq wq
command W w
command Q q

"order matters here
let g:solarized_termtrans=1
set background=dark
set t_Co=256
colorscheme solarized

"transparency behind line numbers
highlight LineNr ctermbg=NONE

let g:khuno_max_line_length=110
let g:khuno_ignore="E128"
"coloring for khuno errors 
highlight SpellBad cterm=underline ctermfg=189

"this is for airline
set ttimeoutlen=50

let g:airline_theme='solarized'

"autocmd FileType python compiler pylint

