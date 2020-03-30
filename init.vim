" Plug for plugins
call plug#begin('~/.vim/plugged')

" fzf (fuzzy find) integration
Plug 'junegunn/fzf'

" ctrl-p file finder
Plug 'kien/ctrlp.vim'

" Git Commands
Plug 'tpope/vim-fugitive'

" Neovim specific plugins
Plug 'neomake/neomake'

" Quoting and parenthesizing made easy
Plug 'tpope/vim-surround'

" Searching with AG
Plug 'rking/ag.vim'

" Make commenting easier
Plug 'tpope/vim-commentary'

" make netrw way better
Plug 'tpope/vim-vinegar'

" the git gutter for changes
Plug 'airblade/vim-gitgutter'

" colors
Plug 'chriskempson/base16-vim'

" run tests from within vim
Plug 'janko-m/vim-test'

" Allow yaml files to be folded
Plug 'digitalrounin/vim-yaml-folds'

" Jump between errors
Plug 'tpope/vim-unimpaired'

" Vim Dispatch
Plug 'tpope/vim-dispatch'

" Hooks up neovim supports to vim-dispatch
Plug 'radenling/vim-dispatch-neovim'

" Statusline plugin
Plug 'bluz71/vim-moonfly-statusline'

" Provides additional text objects
Plug 'wellle/targets.vim'

call plug#end()

" Syntax highlighting FTW
syntax on

" Set background to dark for base16
set background=dark

" Move swp to a standard location
set directory=/tmp

" Setting Spacing and Indent (plus line no)
set number
set tabstop=2 shiftwidth=2 expandtab
set softtabstop=0
set nowrap

" Remap the leader key
:let mapleader = ','

" yank to clipboard alias
vnoremap <leader>y "*y

" paste from clipboard alias
map <leader>p "*p

" Set 256 colors
set t_Co=256
set guifont=Inconsolata:h16

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" configure the invisible chars
set listchars=trail:.,extends:#,nbsp:.

" Run neomake, it's like syntastic
autocmd! BufWritePost * Neomake

" Make YAML Great Again
autocmd FileType yaml setlocal indentexpr=

" Markdown textwidth
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.markdown textwidth=80

" FZF plugin mappings
" FZF with the list of files managed by git
noremap <c-s> :call fzf#run(fzf#wrap({'source': 'git ls-files', 'down': '50%'}))<cr>

" CtrlP mappings
let g:ctrlp_max_files=20000
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|tmp|log|node_modules|bin|vendor)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Git plugin mappings
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gg :Gbrowse<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gv :Gitv<cr>
nnoremap <leader>gpl :Git pull --rebase<cr>
nnoremap <leader>gps :Git push origin head<cr>

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" neomake sucks at highlighting
hi! link NeomakeWarningSign SignColumn
hi! link NeomakeWarning NeomakeMessageDefault

" shortcuts for testing code (vim-test plugin)
nmap <silent> <leader>t :w<CR>:TestNearest<CR>
nmap <silent> <leader>T :w<CR>:TestFile<CR>
nmap <silent> <leader>a :w<CR>:TestSuite<CR>
nmap <silent> <leader>l :w<CR>:TestLast<CR>
nmap <silent> <leader>g :w<CR>:TestVisit<CR>

" disables folding throughout
set nofoldenable

" no lint checking in YAML
let g:neomake_yaml_enabled_makers = []

let g:airline_theme='base16'

nmap <silent> <leader>- :set iskeyword+=-<cr>
nmap <silent> <leader>_ :set iskeyword-=-<cr>
set iskeyword+=-

" shortcut to remove searched highlights
:nnoremap <leader><space> :nohlsearch<cr>

" Make editing lots of files at once easier by mapping ctrl+j and k to jump
" through windows quickly and make them big.  At the same time, decrease
" the minimum window height since the filename is often all we really need to see.
noremap <c-j> <c-w>j<c-w>_
noremap <c-k> <c-w>k<c-w>_
set winminheight=0

" Press <leader> v to open neovim init.vim (this file, even!)
noremap <silent> <leader>v :split ~/.config/nvim/init.vim<CR>

" reloads .neovim init.vim -- making all changes active
noremap <silent> <Leader>V :source ~/.config/nvim/init.vim<CR>:PlugInstall<CR>:exe ":echo 'init.vim reloaded'"<CR>

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

" Run rspec on the current file in Dispatch by pressing F10
nnoremap <F10> :w<CR>:Dispatch bundle exec rspec %<CR>
"
" use jj to quickly escape to normal mode while typing <- AWESOME tip
inoremap jj <ESC>

" Statusline settings for 'vim-moonfly-statusline'
let g:moonflyHonerUserDefinedColors = 1
highlight! link User1 StatusLine
highlight! link User2 DiffAdd
highlight! link User3 DiffChange
highlight! link User4 DiffDelete
highlight! link User5 StatusLine
highlight! link User6 StatusLine
highlight! link User7 StatusLine

" Set compiler to the bundle_exec_rspec compiler for Ruby files
au BufRead,BufNewFile *.rb compiler bundle_exec_rspec
