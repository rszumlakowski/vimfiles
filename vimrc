" This configuration applies to both vim and neovim.

" Plug for plugins
call plug#begin('~/.vim/plugged')

" Git Commands
Plug 'tpope/vim-fugitive'

" Quoting and parenthesizing made easy
Plug 'tpope/vim-surround'

" Make commenting easier
Plug 'tpope/vim-commentary'

" make netrw way better
Plug 'tpope/vim-vinegar'

" Jump between errors
Plug 'tpope/vim-unimpaired'

" Vim Dispatch
Plug 'tpope/vim-dispatch'

" Repeat plugin
Plug 'tpope/vim-repeat'

" fzf (fuzzy find) integration
Plug 'junegunn/fzf'

" ctrl-p file finder
Plug 'ctrlpvim/ctrlp.vim'

" Searching with ack
Plug 'mileszs/ack.vim'

" the git gutter for changes
Plug 'airblade/vim-gitgutter'

" Git log viewer
Plug 'rbong/vim-flog'

" Start screen
Plug 'mhinz/vim-startify'

" colors
Plug 'chriskempson/base16-vim'

" run tests from within vim
Plug 'janko-m/vim-test'

" Hooks up neovim supports to vim-dispatch
if has('nvim')
  Plug 'radenling/vim-dispatch-neovim'
end

" Completion plugin
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
end

" Statusline plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Provides additional text objects
Plug 'wellle/targets.vim'

" Tagbar plugin
Plug 'majutsushi/tagbar'

" Match up plugin
Plug 'andymass/vim-matchup'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Dev icons
Plug 'ryanoasis/vim-devicons'

" Align text plugin
Plug 'junegunn/vim-easy-align'

" TOML file format plugin
Plug 'cespare/vim-toml'

" Rust plugin for vim
Plug 'rust-lang/rust.vim'

" Rego script plugin
Plug 'tsandall/vim-rego'

" Show vertical lines on indents (good for YAML)
Plug 'Yggdroot/indentLine'

" Modifies YAML folding rules
Plug 'pedrohdz/vim-yaml-folds'

" Alternate YAML plugin. Fixes the syntax highlighting in embedded documents
" in YAML files.
Plug 'stephpy/vim-yaml'

" Golang programming
Plug 'fatih/vim-go'

" Makes splitting and joining lines of code easier
Plug 'AndrewRadev/splitjoin.vim'

call plug#end()

" Syntax highlighting FTW
syntax on

let base16colorspace=256

" Set background to dark for base16
set background=dark

" Set 256 colors
set t_Co=256

colorscheme base16-default-dark

" Move swp to a standard location
set directory=/tmp

" Setting Spacing and Indent (plus line no)
set number
set tabstop=2 shiftwidth=2 expandtab
set softtabstop=0
set nowrap

" Remap the leader key
let mapleader = ','

" configure the invisible chars
set listchars=trail:.,extends:#,nbsp:.

" F7 to show the Tagbar window
nmap <F7> :TagbarToggle<CR>

" Make YAML Great Again
autocmd FileType yaml setlocal indentexpr=

" Markdown textwidth
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.markdown textwidth=80

" FZF plugin mappings
" FZF with the list of files managed by git
noremap <c-s> :call fzf#run(fzf#wrap({'source': 'git ls-files', 'down': '50%'}))<cr>

" CtrlP settings
let g:ctrlp_max_files=20000
nmap <C-l> :CtrlPMRU<cr>

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|tmp|log|node_modules|bin|vendor|target)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Causes the swapfile to be update more promptly, which enables GitGutter to
" redraw sooner
set updatetime=100

" Gitgutter mappings
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" Git plugin mappings
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gg :Gbrowse<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gv :Gitv<cr>
nnoremap <leader>gpr :Git pull --rebase<cr>
nnoremap <leader>gps :Git push origin head<cr>

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
end

" shortcuts for testing code (vim-test plugin)
nmap <silent> <leader>t :w<CR>:TestNearest<CR>
nmap <silent> <leader>T :w<CR>:TestFile<CR>
nmap <silent> <leader>a :w<CR>:TestSuite<CR>
nmap <silent> <leader>l :w<CR>:TestLast<CR>
nmap <silent> <leader>g :w<CR>:TestVisit<CR>

" disables folding throughout
set nofoldenable

nmap <silent> <leader>- :set iskeyword+=-<cr>
nmap <silent> <leader>_ :set iskeyword-=-<cr>
set iskeyword+=-

" shortcut to remove search highlights
:nnoremap <leader><space> :nohlsearch<cr>

" Make editing lots of files at once easier by mapping ctrl+j and k to jump
" through windows quickly and make them big.  At the same time, decrease
" the minimum window height since the filename is often all we really need to see.
noremap <c-j> <c-w>j<c-w>_
noremap <c-k> <c-w>k<c-w>_
set winminheight=0

" Press <leader> v to open vimrc
noremap <silent> <leader>v :vsplit ~/.vim/vimrc<CR>

" reloads vimrc -- making all changes active
noremap <silent> <Leader>V :source ~/.vim/vimrc<CR>:PlugInstall<CR>:exe ":echo 'vimrc reloaded'"<CR>

" we don't want vim to treat numbers as in octal format
" when using the ctrl-a and ctrl-x commands
set nrformats=hex

" maximum line length for syntax highlighting (for performance reasons)
set synmaxcol=300

" Exit insert mode in the terminal window with Ctrl O
if has('nvim')
  tmap <C-o> <C-\><C-n>
end

" Run Dispatch by pressing F9
nnoremap <F9> :wa<CR>:Dispatch<CR>
"
" use jj to quickly escape to normal mode while typing <- AWESOME tip
inoremap jj <ESC>

" Compiler settings based on file types
autocmd BufRead,BufNewFile *.rb compiler bundle_exec_rspec
autocmd BufRead,BufNewFile *.rs compiler cargo
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit') " vim-go plugin
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit') " vim-go plugin
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split') " vim-go plugin
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe') " vim-go plugin
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" Shows Go function and variable info automatically when the cursor
" is on top of one
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

" Starts deoplete at startup
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#option('omni_patterns', {
        \ 'go': '[^. *\t]\.\w*',
        \})
end

" Airline statusbar settings
let g:airline_theme='papercolor'

" Search customization
let g:ack_default_options = " --ignore-file=is:tags --ignore-file=ext:log --ignore-dir=.git --ignore-dir=.idea --ignore-dir=log --ignore-dir=vendor --ignore-dir=tmp -s --with-filename --nogroup --column"

" Startify plugin settings
if has('nvim')
  let g:startify_custom_header = [
        \ '     d8b   db d88888b  .d88b.  db    db d888888b .88b  d88. ',
        \ '     888o  88 88      .8P  Y8. 88    88   `88    88 YbdP`88 ',
        \ '     88V8o 88 88ooooo 88    88 Y8    8P    88    88  88  88 ',
        \ '     88 V8o88 88~~~~~ 88    88 `8b  d8     88    88  88  88 ',
        \ '     88  V888 88.     `8b  d8   `8bd8     .88.   88  88  88 ',
        \ '     VP   V8P Y88888P  `Y88P      YP    Y888888P YP  YP  YP ',
        \ ]
else
  let g:startify_custom_header = [
        \ '     db    db d888888b .88b  d88. ',
        \ '     88    88   `88    88 YbdP`88 ',
        \ '     Y8    8P    88    88  88  88 ',
        \ '     `8b  d8     88    88  88  88 ',
        \ '      `8bd8     .88.   88  88  88 ',
        \ '        YP    Y888888P YP  YP  YP ',
        \ ]
end

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
