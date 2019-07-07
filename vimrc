""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" color scheme
 colorscheme elflord
"  colorscheme solarized
" colorscheme desert
" allow switching between buffers without writing them
set hidden
" how many line of history
set history=5000
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
set scrolloff=10
set sidescrolloff=10
" scroll sideways a character at a time, rather than a screen at a time
set sidescroll=1
" allow motions and back-spacing over line-endings etc
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>
" underscores denote words
set iskeyword+=-
" :W sudo saves the file
command! W w !sudo tee % > /dev/null
" enable filetype plugins
filetype plugin on
filetype indent on
" backup, undo and swap files (in another directory)
if !isdirectory($HOME."/.vim/tmp/undo-dir")
  call mkdir($HOME."/.vim/tmp/undo-dir", "p", 0750)
endif
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp/undo-dir
set backup
set swapfile
set undofile
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
" Line number
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
highlight LineNr ctermfg=grey
set cursorline
highlight clear CursorLine

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" text, tab and indent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" insert spaces instead of tab characters
set expandtab
" display special char for weird space (fighting yaml o/)
set listchars=nbsp:☠,tab:▸␣
" size of an indent measured in spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2
" auto indent
set autoindent
" wrap lines
set wrap
" don't insert space after J
set nojoinspaces
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
" close buffer
nnoremap <leader>d :bd<cr>
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
" exit insert mode with jk
inoremap jk <esc>
" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" reload vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" single quote the current word
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
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
nnoremap <s-h> :let @/ = ""<cr>
" open an explorer
nnoremap <leader>e :Vexplore!<cr>
" map <Space> to /
nnoremap <space> /
" limit line-length to 80 columns by highlighting col 81 onward
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
" comment / uncomment selection
vnoremap <leader>c :s/^/#/<cr>:let @/ = ""<cr>
vnoremap <leader>C :s/^#//<cr>:let @/ = ""<cr>
" execute (run) current file
nnoremap <leader>r :w<cr>:!./%
" ctrl + j to break line
" nnoremap <nl> i<cr><esc>
" create a mark and jump to next tag matching word under the cursor
nnoremap <leader>j :%!python -m json.tool<cr>
" toggle line number
nnoremap <leader>n :set number!<cr>
" :%s//g shortcut
nnoremap S :%s//g<left><left>
vnoremap S :s//g<left><left>
" french keyboard... ' is preferred over ` when it comes to marks
nnoremap ' `
let g:vimwiki_list = [{'path': '~/doc/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext=0
" synchronize scrolling over mutliple windows
nnoremap <leader>s :set scrollbind!<cr>
" copy full buffer into X11 clipboard (requires vimx)
nnoremap <leader>y mygg"+yG`y
" do not use arrows
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" gf create the file under the cursor if it doesn't exist
map gf :e <cfile><cr>
" change working dir to current file path
map <leader>cd :cd %:h<cr>
" replace visual selection by content of unamed register
vmap r "_dP

" plugins
" highligth next/previous occurence of pattern
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
if &diff
  syntax off
endif
" auto commit vimwiki
function! AutoGitCommit()
  execute '!cd ' . expand("<amatch>:p:h") . ' && git add "' . expand("%:t") . '" && git commit -m "Auto commit of ' .  expand("<afile>:t") . '"  && git push origin'
endfunction
autocmd! BufWritePost ~/doc/* call AutoGitCommit()
" ctrp
set runtimepath^=~/.vim/bundle/ctrlp.vim
