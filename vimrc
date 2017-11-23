" Rob's custom vimrc file.
" Based off of this blog post: https://blog.hellojs.org/configure-vim-from-scratch-efe5cbc1c563

" Summary of custom key mappings:
"
" The leader key is , (comma)
"
" ,f or ^p   # fuzzy search by filename
" ,fe        # open netrw file explorer
" ,fm        # fuzzy search most-recently-used-files
" gc<motion> # Comment/uncomment a line or range of lines.
" ^- ^-      # Comment/uncomment a line or range of lines.
" ^- p       # Comment/uncomment inner paragraph
" ^- b       # Comment/uncomment as a block

set nocompatible

" no need filetype to load plugins
filetype off

" specify a directory for plugins
"
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" TODO - See if you can figure out how to load the plugins using
"        vim8's own plug-in manager.

" Add a list of plugins to load using the 'Plugged' plugin manager.
" Reload .vimrc and run the 'PlugInstall' command to install plugins.
" Don't commit plugins to vimrc - they are their own git submodules.

"  make sure you use single quotes
Plug 'tomtom/tcomment_vim' " Comments lines
Plug 'ctrlpvim/ctrlp.vim'  " Fuzzy search
Plug 'itchyny/lightline.vim' " Status line
" I used to load various language pack
" 'vim-perl/vim-perl', 'lambdatoast/elm.vim'...
" polyglot load them among other => One to rule them all
Plug 'sheerun/vim-polyglot' " Syntax highlighting
Plug 'editorconfig/editorconfig-vim' " Load editor configuration files (.editorconfig)
Plug 'godlygeek/tabular' " Helps align things
Plug 'tpope/vim-dispatch' " Asynchronously dispatch commands to tmux
Plug 'mileszs/ack.vim' " Wrapper for 'ack' search tool
Plug 'danchoi/ri.vim' " Plugin helps browse ruby documentation

" initialize plugin system
call plug#end()

" activate filetype detection now that plugins are loaded
filetype plugin on

" turn on syntax files
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make backspaces delete sensibly
set backspace=indent,eol,start

" to autosave buffer (useful when switching between buffer)
set autowrite

" configure the invisible chars
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" ignore case if search pattern is all lowercase,
"    case-sensitive otherwise (both smartcase and ignorecase needed)
set smartcase
set ignorecase

" to keep backup and swap files in my home dir
set backupdir=~/.vim/tmp/                   " for the backup files
set directory=~/.vim/tmp/                   " for the swap files

"
" Netrw

" absolute width of netrw window
let g:netrw_winsize = -28

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" open file in a new tab
let g:netrw_browse_split = 3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline

"let g:lightline = { 'colorscheme': 'solarized', }               "vim-lightline
set laststatus=2                                                "vim-lightline
set noshowmode                                                  "vim-lightline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editorconfig

" don't have vim compiled with python => use external editorconfig
let g:EditorConfig_core_mode = 'external_command'               "editorconfig-vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-markdown-previw

let vim_markdown_preview_toggle=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   KEYS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General

let mapleader = ','

" use jj to quickly escape to normal mode while typing <- AWESOME tip
inoremap jj <ESC>

" insert newline without entering insert mode
map <CR> o<Esc>k

" Make editing lots of files at once easier by mapping ctrl+j and k to jump
" through windows quickly and make them big.  At the same time, decrease
" the minimum window height since the filename is often all we really need to see.
noremap <c-j> <c-w>j<c-w>_ 
noremap <c-k> <c-w>k<c-w>_
set winminheight=0

" Turn on incremental searching
set incsearch

" Show the matching bracket for the last ')'
set showmatch

" Don't changes the sizes of existing windows when opening or closing new ones
set noequalalways

" Let vim makes typing in multiline comments easier
set formatoptions+=roc

" Turn on highlighting of search results
set hlsearch

" Pressing leader u creates an underline under the current line
noremap <silent> <Leader>u Yp:s/./-/g<CR>:noh<CR>j

" Press <leader> v to open vimrc (this file, even!)
noremap <silent> <leader>v :split ~/.vim/vimrc<CR>

" reloads .vimrc -- making all changes active
noremap <silent> <Leader>r :source ~/.vim/vimrc<CR>:PlugInstall<CR>:exe ":echo 'vimrc reloaded'"<CR>

" we don't want vim to treat numbers as in octal format
" when using the ctrl-a and ctrl-x commands
set nrformats=hex

" don't word wrap
set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader F prefix is for file related mappings (open, browse...)

nnoremap <silent> <Leader>f :CtrlP<CR>                          "ctrlp.vim
nnoremap <silent> <Leader>fm :CtrlPMRU<CR>                      "ctrlp.vim

" don't need NerdTree, Netrw is enough for me
nnoremap <silent> <Leader>fe :Lexplore <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader B prefix is for buffer related mappings

nnoremap <silent> <Leader>b  :CtrlPBuffer<CR>                   "ctrlp.vim
nnoremap <silent> <Leader>bb :bn<CR>
nnoremap <silent> <Leader>bd :bdelete<CR>

" (un)lock the current buffer to prevent modification
nnoremap <silent> <Leader>bl :set nomodifiable<CR>
nnoremap <silent> <Leader>bu :set modifiable<CR>
