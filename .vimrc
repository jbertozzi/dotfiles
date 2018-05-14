""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" color scheme
" colorscheme elflord
colorscheme desert
" how many line of history
set history=500
" re-load file when modified from outisde
set autoread
" encoding
set encoding=utf-8
" enable syntax highighting
syntax enable
" custom leader / localleader
let mapleader = ","
let maplocalleader = ","
" 256 colours
set t_Co=256
" start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5
" scroll sideways a character at a time, rather than a screen at a time
set sidescroll=1
" allow motions and back-spacing over line-endings etc
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>
" underscores denote words
set iskeyword-=_-
" :W sudo saves the file
command! W w !sudo tee % > /dev/null
" enable filetype plugins
filetype plugin on
filetype indent on
" backup and swap files
set backup
set swapfile
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
" tags file
set tags=.tags
" show file title in terminal tab
set title
" rename pane with file name
if exists('$TMUX')
    autocmd BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
    autocmd VimLeave * call system("tmux setw automatic-rename")
endif
" return to last edit position when opening files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" text, tab and indent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" insert spaces instead of tab characters
set expandtab
" size of an indent measured in spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2
" auto indent
set autoindent
" wrap lines
set wrap
" language specific
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType yaml setlocal keywordprg=ansible-doc autoindent tabstop=2 shiftwidth=2 expandtab
autocmd FileType vim setlocal keywordprg=:help
autocmd FileType python setlocal keywordprg=pydoc autoindent tabstop=4 shiftwidth=4 expandtab
autocmd FileType perl setlocal keywordprg=perldoc  autoindent tabstop=2 shiftwidth=2 expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show status line
set laststatus=2
" format satus line
set statusline=%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" show what mode you're currently in
set showmode
" show what commands you're typing
set showcmd
" allow modelines
set modeline
" show current line and column position in file
set ruler

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" search related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" keep results highlighted after a search
set hlsearch
" highlight as we type
set incsearch
" ignore case when searching...
set ignorecase
" except if we type a capital letter
set smartcase
" For autocompletion ctrl-x ctrl-k
" ctrl-n / ctrl-p for word completion
set dictionary=/usr/share/dict/words

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tab, buffer and window configuration (TO DO)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" always open new windows on the right
set splitright
" tab style
highlight TabLineSel cterm=underline,bold ctermfg=White ctermbg=DarkGrey
highlight TabLine cterm=None
highlight TabLineFill ctermfg=Black
" close all the buffers
nnoremap <leader>ba :bufdo bd<cr>
" next buffer
nnoremap <tab> :bnext<cr>
" previous buffer
nnoremap <s-tab> :bprevious<cr>
" open a new tab
nnoremap <leader>tn :tabnew<cr>
" send all the open buffers and open a dedicated tab
nnoremap <leader>ta :tab sball<cr>
" close all tab exepect the current one
nnoremap <leader>to :tabonly<cr>
" close current tab
nnoremap <leader>tc :tabclose<cr>
" move tab as first
nnoremap <leader>tf :tabmove 0 <cr>
" navigate between windows
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
" all new buffers go into a separate tab
" autocmd BufAdd,BufNewFile,BufRead * nested tab sball

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" useful mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" reload vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" double quote the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" current word lower case
nnoremap <leader>l evbu
" current word upper case
nnoremap <leader>u evbU
" current line lower case
nnoremap <leader>L ^V$u
" current line upper case
nnoremap <leader>U ^V$U
" shift tab to insert tab char
inoremap <s-tab> <c-v><tab>
" operate inside parantheses (dp delete function parameter)
onoremap p i(
" shift H to clear search highlighting
nnoremap <s-h> :set hlsearch!<cr>
map <silent> <leader><cr> :set hlsearch!<cr>
" open an explorer
nnoremap <leader>e :Vexplore!<cr>
" map <Space> to /
nnoremap <space> /
" Limit line-length to 80 columns by highlighting col 81 onward
nnoremap <leader>m :set colorcolumn=81<cr>
nnoremap <leader>M :set colorcolumn=0<cr>
" strip white space
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

nnoremap <leader>ss :call StripWhitespace()<cr>
