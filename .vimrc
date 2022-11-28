" Get the defaults that most users want.
" source $VIMRUNTIME/defaults.vim

set nocompatible                    " Don't make Vim vi-compatibile.

syntax on

set encoding=utf-8 nobomb           " Use UTF-8 without BOM.

set mouse=a                         " Enable mouse in all modes.

if has('autocmd')
    filetype plugin indent on
    "           │     │    └──────── Enable file type detection.
    "           │     └───────────── Enable loading of indent file.
    "           └─────────────────── Enable loading of plugin files.
endif

set autoindent                      " Copy indent to the new line.
set smartindent

set nostartofline                   " Don’t reset cursor to start of
                                    " line when moving around.

set splitbelow                      " Open new splits to the right of
set splitright                      " or below the current window.

set backspace=indent                " ┐
set backspace+=eol                  " │ Allow `backspace`
set backspace+=start                " ┘ in insert mode.

set clipboard=unnamed               " ┐
                                    " │ Use the system clipboard
if has('unnamedplus')               " │ as the default register.
    set clipboard+=unnamedplus      " │
endif                               " ┘

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups        " Set directory for backup files.
set directory=~/.vim/swaps          " Set directory for swap files.
if has('persistent_undo')
    set undodir=~/.vim/undos        " Set directory for undo files.
    set undofile                    " Save undo history.
endif

if has('wildignore')
    set backupskip=/tmp/*           " ┐ Don't create backups
    set backupskip+=/private/tmp/*  " ┘ for certain files.
endif

if has('cmdline_hist')
    set history=5000                " Increase command line history.
endif

if has('extra_search')

    set hlsearch                    " Enable search highlighting.

    set incsearch                   " Highlight search pattern
                                    " as it is being typed.
endif

set ignorecase                      " Ignore case in search patterns.

set smartcase                       " Override `ignorecase` option
                                    " if the search pattern contains
                                    " uppercase characters.

set title                           " Show filename in the window titlebar.

set laststatus=2                    " Always show the status line.

set lazyredraw                      " Do not redraw the screen while
                                    " executing macros, registers
                                    " and other commands that have
                                    " not been typed.

set listchars=tab:▸\                " ┐
set listchars+=trail:·              " │ Use custom symbols to
set listchars+=eol:¬                " │ represent invisible characters.
set listchars+=nbsp:_               " ┘

set magic                           " Enable extended regexp.
set noerrorbells                    " Disable error bells.

set nojoinspaces                    " When using the join command,
                                    " only insert a single space
                                    " after a `.`, `?`, or `!`.

set number                          " Show line number.


if has('linebreak')
    set numberwidth=5               " Increase the minimal number of
                                    " columns used for the `line number`.
endif

set report=0                        " Report the number of lines changed.

set scrolloff=5                     " When scrolling, keep the cursor
                                    " 5 lines below the top and 5 lines
                                    " above the bottom of the screen.

set shortmess=aAItW                 " Avoid all the hit-enter prompts.

if has('cmdline_info')
    set showcmd                     " Show the command being typed.
endif

set showmode                        " Show current mode.

if has('syntax')
    set spelllang=en_us             " Set the spellchecking language.
endif

if has('syntax')
    set synmaxcol=2500              " Limit syntax highlighting (this
                                    " avoids the very slow redrawing
                                    " when files contain long lines).
endif

set tabstop=4                       " ┐
set softtabstop=4                   " │ Set global <TAB> settings.
set shiftwidth=4                    " │
set expandtab                       " ┘

set ttyfast                         " Enable fast terminal connection.

set wildmode=list:longest           " ┐ List all completion matches and
set wildmode+=list:full             " ┘ complete longest common string.

if has('wildmenu')
    set wildmenu                    " Enable enhanced command-line
endif                               " completion (by hitting <TAB> in
                                    " command mode, Vim will show the
                                    " possible matches just above the
                                    " command line with the first
                                    " match highlighted).

set timeout                         " ┐ Get rid of the delay after pressing
set timeoutlen=1000                 " │ character after escape (e.g., O):
set ttimeoutlen=100                 " ┘ https://stackoverflow.com/q/2158516/5536037

set hidden                          " Throw error if unsaved hidden buffers

set autoread                        " Autoload files that changed outside of vim

set showmatch                       " Highlight matching brace/bracket/paren.

set showbreak=←←                    " Indicate a line wrap continuation.


" ----------------------------------------------------------------------
" | Plugins                                                            |
" ----------------------------------------------------------------------

" Use `minpac` to manage the Vim plugins.
" https://github.com/k-takata/minpac

function! InitPlugins() abort

    packadd minpac

    call minpac#init()
    call minpac#add('k-takata/minpac', { 'type': 'opt' })

    call minpac#add('altercation/vim-colors-solarized')
    call minpac#add('ap/vim-css-color')
    call minpac#add('chrisbra/unicode.vim')
    call minpac#add('editorconfig/editorconfig-vim')
    call minpac#add('godlygeek/tabular')
    call minpac#add('isRuslan/vim-es6')
    call minpac#add('jelera/vim-javascript-syntax')
    call minpac#add('mattn/webapi-vim')
    call minpac#add('mhinz/vim-signify')
    call minpac#add('moll/vim-node')
    call minpac#add('mtscout6/syntastic-local-eslint.vim')
    call minpac#add('raimondi/delimitmate')
    call minpac#add('scrooloose/nerdtree')
    call minpac#add('scrooloose/syntastic')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('shougo/neocomplcache.vim')
    call minpac#add('shougo/neosnippet')
    call minpac#add('shougo/neosnippet-snippets')
    call minpac#add('tomtom/tcomment_vim')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('wellle/targets.vim')

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Define custom commands for managing plugins.

command! PluginsClean   call InitPlugins() | call minpac#clean()
command! PluginsSetup   call InitPlugins() | call minpac#update('', {'do': 'quit'})
command! PluginsStatus  call InitPlugins() | call minpac#status()
command! PluginsUpdate  call InitPlugins() | call minpac#update('', {'do': 'call minpac#status()'})


" ----------------------------------------------------------------------
" | Plugins - Markdown                                                 |
" ----------------------------------------------------------------------

" Disable Folding.
" https://github.com/plasticboy/vim-markdown#disable-folding

let g:vim_markdown_folding_disabled=1


" ----------------------------------------------------------------------
" | Plugins - NeoComplCache                                            |
" ----------------------------------------------------------------------

" Disable `neocomplcache` by default. It causes some where flashing
" messages when using cursor keys in insert mode.
" https://github.com/Shougo/neocomplcache.vim#installation

let g:neocomplcache_enable_at_startup=0
let g:neocomplcache_enable_insert_char_pre=1

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Make `Tab` autocomplete.

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Make `Shift+Tab` insert `Tab` character.

inoremap <S-TAB> <C-V><TAB>


" ----------------------------------------------------------------------
" | Plugins - Signify                                                  |
" ----------------------------------------------------------------------

" Disable Signify by default.
" https://github.com/mhinz/vim-signify

let g:signify_disable_by_default=1


" ----------------------------------------------------------------------
" | Plugins - Syntastic                                                |
" ----------------------------------------------------------------------

" Inform Syntastic which checkers to use based on file types.
" https://github.com/scrooloose/syntastic#faq

let g:syntastic_javascript_checkers = [ 'eslint' ]

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" Disable syntax checking by default.

let g:syntastic_mode_map = {
    \ "active_filetypes": [],
    \ "mode": "passive",
    \ "passive_filetypes": []
\}


" ----------------------------------------------------------------------
" | Helper Functions                                                   |
" ----------------------------------------------------------------------

function! GetGitBranchName()

    let branchName = ""

    if exists("g:loaded_fugitive")
        let head = FugitiveHead(6)
        if head == ""
            return head
        endif
        let branchName = " " . head . " "
    endif

    return branchName

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! StripTrailingWhitespaces()

    " Save last search and cursor position.

    let searchHistory = @/
    let cursorLine = line(".")
    let cursorColumn = col(".")

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Strip trailing whitespaces.

    %s/\s\+$//e

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Restore previous search history and cursor position.

    let @/ = searchHistory
    call cursor(cursorLine, cursorColumn)


endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleLimits()

    " [51,73]
    "
    "   * Git commit message
    "     http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
    "
    " [81]
    "
    "   * general use

    if ( &colorcolumn == "73" )
        set colorcolumn+=51,81
    else
        set colorcolumn-=51,81
    endif

endfunction

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function! ToggleRelativeLineNumbers()

    if ( &relativenumber == 1 )
        set number
    else
        set relativenumber
    endif

endfunction


" ----------------------------------------------------------------------
" | Automatic Commands                                                 |
" ----------------------------------------------------------------------

if has("autocmd")

    " Autocommand Groups.
    " http://learnvimscriptthehardway.stevelosh.com/chapters/14.html

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


    " Automatically reload the configurations from
    " the `~/.vimrc` file whenever they are changed.

    augroup auto_reload_vim_configs

        autocmd!
        autocmd BufWritePost vim source $HOME/.vimrc

    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Use relative line numbers.
    " http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/

    augroup relative_line_numbers

        autocmd!

        " Automatically switch to absolute
        " line numbers when Vim loses focus.
        autocmd FocusLost * :set number

        " Automatically switch to relative
        " line numbers when Vim gains focus.
        autocmd FocusGained * :set relativenumber

        " Automatically switch to absolute
        " line numbers when Vim is in insert mode.
        autocmd InsertEnter * :set number

        " Automatically switch to relative
        " line numbers when Vim is in normal mode.
        autocmd InsertLeave * :set relativenumber


    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Automatically strip the trailing
    " whitespaces when files are saved.

    augroup strip_trailing_whitespaces

        autocmd!

        " List of file types for which the trailing whitespaces
        " should not be removed:
        let excludedFileTypes = []

        " Only strip the trailing whitespaces if
        " the file type is not in the excluded list.
        autocmd BufWritePre * if index(excludedFileTypes, &ft) < 0 | :call StripTrailingWhitespaces()

    augroup END

    " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    " Assign filetypes and custom filetype settings

    augroup custom_filetypes

        autocmd!

        " Treat .json files as .js
        autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

        " Treat .md files as Markdown
        autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

        " in makefiles, don't expand tabs to spaces, since actual tab characters are
        " needed, and have indentation at 8 chars to be sure that all indents are tabs
        " (despite the mappings later):
        autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

        " Set a text width limit for git commit messages
        autocmd Filetype gitcommit setlocal textwidth=72

        " Disable modeline for commit messages since it bugs out with certain
        " commit messages
        autocmd Filetype gitcommit,gitrebase setlocal nomodeline

        " Color gitcommit files the same as git status
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitSummary cterm=NONE ctermfg=14 ctermbg=8
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitOverflow cterm=NONE ctermfg=10 ctermbg=8
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitBranch cterm=NONE ctermfg=7 ctermbg=8
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitSelectedType cterm=NONE ctermfg=3 ctermbg=8
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitSelectedFile cterm=NONE ctermfg=3 ctermbg=8
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitDiscardedType cterm=NONE ctermfg=2 ctermbg=8
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitDiscardedFile cterm=NONE ctermfg=2 ctermbg=8
        autocmd Filetype gitcommit,gitrebase
            \ hi gitcommitUntrackedFile cterm=NONE ctermfg=6 ctermbg=8
    augroup END
endif

" ----------------------------------------------------------------------
" | Color Scheme                                                       |
" ----------------------------------------------------------------------

set t_Co=256                   " Enable full-color support.

set background=dark            " Use colors that look good
                               " on a dark background.

" Set custom configurations for when the
" Solarized theme is used from Vim's Terminal mode.
"
" https://github.com/altercation/vim-colors-solarized

if !has("gui_running")
    " let g:solarized_contrast = "high"
    " let g:solarized_termcolors = 256
    let g:solarized_termtrans = 1
    " let g:solarized_visibility = "high"
endif

silent! colorscheme solarized  " Use custom color scheme.


" ----------------------------------------------------------------------
" | Key Mappings                                                       |
" ----------------------------------------------------------------------

" Use a different mapleader (default is "\").

let mapleader = ","

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,* ] Search and replace the word under the cursor.

nmap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cc] Toggle code comments.
" https://github.com/tomtom/tcomment_vim

map <leader>cc :TComment<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cr] Calculate result.
" http://vimcasts.org/e/56

nmap <leader>cr 0yt=A<C-r>=<C-r>"<CR><Esc>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,cs] Clear search.

map <leader>cs <Esc>:noh<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,gd] Toggle Git differences.

map <leader>gd :SignifyToggle<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,l ] Toggle `set list`.

nmap <leader>l :set list!<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,n ] Toggle `set relativenumber`.

nmap <leader>n :call ToggleRelativeLineNumbers()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,rl ] Toggle `RainbowLevels`.

map <leader>rl :RainbowLevelsToggle<cr>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,sh] Show hex dump.

nmap <leader>sh :%!xxd<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,sr] Strip carriage returns.

nmap <leader>sr :%s/\r//g<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ss] Strip trailing whitespace.

nmap <leader>ss :call StripTrailingWhitespaces()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,t ] Toggle NERDTree.

map <leader>t :NERDTreeToggle<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ti] Toggle indent.

nmap <leader>ti <Plug>IndentGuidesToggle

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,tl] Toggle show limits.

nmap <leader>tl :call ToggleLimits()<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,ts] Toggle Syntastic.

nmap <leader>ts :SyntasticToggleMode \| w<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,v ] Make the opening of the `.vimrc` file easier.

nmap <leader>v :vsp $HOME/.vimrc<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [,W ] Sudo write.

map <leader>W :w !sudo tee %<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [gc ] Swap current character with next character and retain cursor position

nnoremap <silent> gc xph

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [gw ] Swap current word with next word and retain cursor position

nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [gl ] Swap current word with previous word and keep cursor on current word
" (push left)

nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [gr ] Swap current word with next word and keep cursor on current word
" (push right)

nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" [C-j] move current line or selected blocks up or down in any mode
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv

" [C-k] move current line or selected blocks up or down in any mode
nnoremap <C-k> :m .-2<CR>==
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-k> :m '<-2<CR>gv=gv


" ----------------------------------------------------------------------
" | Status Line                                                        |
" ----------------------------------------------------------------------

" Terminal types:
"
"   1) term  (normal terminals, e.g.: vt100, xterm)
"   2) cterm (color terminals, e.g.: MS-DOS console, color-xterm)
"   3) gui   (GUIs)

highlight ColorColumn
    \ term=NONE
    \ cterm=NONE  ctermbg=237    ctermfg=NONE
    \ gui=NONE    guibg=#073642  guifg=NONE

highlight CursorLineNr
    \ term=bold
    \ cterm=bold  ctermbg=NONE   ctermfg=178
    \ gui=bold    guibg=#073642  guifg=Orange

highlight LineNr
    \ term=NONE
    \ cterm=NONE  ctermfg=10    ctermbg=0
    \ gui=NONE    guifg=NONE  guibg=NONE

highlight User1
    \ term=NONE
    \ cterm=NONE  ctermbg=11    ctermfg=black
    \ gui=NONE    guibg=#073642  guifg=#839496

" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set statusline=
set statusline+=%1*            " User1 highlight
set statusline+=\ [%n]         " Buffer number
set statusline+=\ %{GetGitBranchName()}        " Git branch name
set statusline+=\ [%f]         " File path
set statusline+=%m             " Modified flag
set statusline+=%r             " Readonly flag
set statusline+=%h             " Help file flag
set statusline+=%w             " Preview window flag
set statusline+=%y             " File type
set statusline+=[
set statusline+=%{&ff}         " File format
set statusline+=:
set statusline+=%{strlen(&fenc)?&fenc:'none'}  " File encoding
set statusline+=]
set statusline+=%=             " Left/Right separator
set statusline+=%c             " File encoding
set statusline+=,
set statusline+=%l             " Current line number
set statusline+=/
set statusline+=%L             " Total number of lines
set statusline+=\ (%P)\        " Percent through file

" Example result:
"
"  [1]  master  [vim/vimrc][vim][unix:utf-8]            17,238/381 (59%)


" ----------------------------------------------------------------------
" | Local Settings                                                     |
" ----------------------------------------------------------------------

" Load local settings if they exist.
"
" [!] The following needs to remain at the end of this file in
"     order to allow any of the above settings to be overwritten
"     by the local ones.

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
