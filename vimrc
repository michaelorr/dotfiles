set nocp
syntax on
syntax enable
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set binary
set clipboard=unnamed
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
set colorcolumn=80

"i no type good
command WQ wq
command Wq wq
command W w
command Q q

"order matters here
let g:solarized_termtrans=1
set background=dark
set t_Co=256
colorscheme Tomorrow-Night-Bright
hi normal ctermfg=255 ctermbg=none

"transparency behind line numbers
highlight LineNr ctermbg=NONE

"let g:khuno_max_line_length=110
let g:khuno_ignore="E128,E501"
"coloring for khuno errors
"highlight SpellBad cterm=underline ctermbg=lightred

"this is for airline
set ttimeoutlen=50

let g:airline_theme='tomorrow'

"autocmd FileType python compiler pylint


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
" highlight json correctly
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
autocmd BufNewFile,BufRead {Gemfile,VagrantFile,*.pp} set ft=ruby
