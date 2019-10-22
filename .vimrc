" Get the defaults that most users want.
" source $VIMRUNTIME/defaults.vim

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" ==========
" my configs
" ==========

" Make Vim more useful
set nocompatible
set encoding=utf-8
syntax on

" backups
" set nobackup
" set nowritebackup
" set noswapfile
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4

" convert tabs to spaces
set expandtab
set tabstop=4
set shiftwidth=4

set history=1000

" show line numbers on status line
set ruler

" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif

" with this option on, a buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window.
" If you try and quit Vim while there are hidden buffers, you will raise an error:
" E162: No write since last change for buffer “a.txt”
set hidden

" fix backspace behaviour
set backspace=indent,eol,start

" show trailing spaces
" set list listchars=tab:\ \ ,trail:·
" Show “invisible” characters
" set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set listchars=tab:▸\ ,trail:·
set list

" Ignore case of searches
set ignorecase

" not sure but indenting
set autoindent
" Increase indent in a new block
set smartindent
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
" show partial commands from operator pending mode
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Hide the toolbar
" set guioptions-=T

" Autoload files that have changed outside of vim
set autoread

" better splits
" set splitbelow
" set splitright

" Visual autocomplete for command menu (e.g. :e ~/path/to/file)
" partially lifted from http://stackoverflow.com/a/15583861/4921402
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/.hg/*,*/.svn/*.,*/.DS_Store,*/.idea/*,*/.tmp/*,*/target/*

" highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

" do not wrap long lines
set nowrap

" indicates a wrap line continuation
set showbreak=←←

" redraw only when we need to (i.e. don't redraw when executing a macro)
set lazyredraw

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    " in makefiles, don't expand tabs to spaces, since actual tab characters are
    " needed, and have indentation at 8 chars to be sure that all indents are tabs
    " (despite the mappings later):
    autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
    autocmd Filetype gitcommit setlocal textwidth=72
endif

" key bindings
" swap current character with next character and retain cursor position
nnoremap <silent> gc xph
" swap current word with next word and retain cursor position
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
" swap current word with previous word and keep cursor on current word (push left)
nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
" swap current word with next word and keep cursor on current word (push right)
nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>
" move current line or selected blocks up or down in any mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
