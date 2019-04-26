" Plug for plugins
call plug#begin('~/.vim/plugged')

" File navigation
Plug 'ctrlpvim/ctrlp.vim'

" Git Commands
Plug 'tpope/vim-fugitive'

" Lets do go development
Plug 'fatih/vim-go'

" Neovim specific plugins
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'

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

" hcl syntax
Plug 'fatih/vim-hclfmt'

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

" Go Declaration
au FileType go nmap gd <Plug>(go-def)
let g:go_fmt_command = "goimports"

" Run neomake, it's like syntastic
autocmd! BufWritePost * Neomake

" Turn on go-implements
au FileType go nmap <Leader>s <Plug>(go-implements)

" Turn on go-rename
au FileType go nmap <Leader>e <Plug>(go-rename)

" switch between implementation and test files
au FileType go nmap <Leader>a :vsp<CR>:GoAlternate<CR>

" Make YAML Great Again
autocmd FileType yaml setlocal indentexpr=

" Markdown textwidth
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.markdown textwidth=80

" Amp up the syntax highlighting in vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = ['vet', 'errcheck']

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Take over Tab for deoplete
" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if preceding chars are whitespace, insert tab char
" 3. Otherwise, start manual autocomplete
imap <silent><expr><Tab>
  \ pumvisible() ? "\<C-n>"
  \ : (<SID>is_whitespace() ? "\<Tab>"
  \ : deoplete#mappings#manual_complete())

smap <silent><expr><Tab>
  \ pumvisible() ? "\<C-n>"
  \ : (<SID>is_whitespace() ? "\<Tab>"
  \ : deoplete#mappings#manual_complete())

inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:is_whitespace() "{{{
  let col = col('.') - 1
  return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}

" Make deoplete insert a line when closing prompt
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#mappings#close_popup() . "\<CR>"
endfunction

" Git plugin mappings
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gg :Gbrowse<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gv :Gitv<cr>
nnoremap <leader>gpl :Git pull --rebase<cr>
nnoremap <leader>gps :Git push origin head<cr>

:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" neomake sucks at highlighting
hi! link NeomakeWarningSign SignColumn
hi! link NeomakeWarning NeomakeMessageDefault

" this provides ability to flip between test and implementation
" nice shortcut, if we hate it we can remove
map <leader>. :GoAlternate<CR>

" set ginkgo as test framework in golang
let test#go#runner = 'ginkgo'

" shortcuts for testing code (vim-test plugin)
nmap <silent> <leader>t :w<CR>:TestNearest<CR>
nmap <silent> <leader>T :w<CR>:TestFile<CR>
nmap <silent> <leader>a :w<CR>:TestSuite<CR>
nmap <silent> <leader>l :w<CR>:TestLast<CR>
nmap <silent> <leader>g :w<CR>:TestVisit<CR>

" disables folding throughout
set nofoldenable

" alternate to invoke ctrl-p
map <Leader>f <C-p>

map <C-l> :CtrlPMRU<CR>

" removes unneeded folders to be searched in
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.git|[\/]vendor$$',
  \ }

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

" Map Ctrl L to open the CtrlP window in MRU mode
noremap <c-l> :CtrlPMRU<CR>

" Exit insert mode in the terminal window with Ctrl O
if has('nvim')
  tmap <C-o> <C-\><C-n>
end

" Run Dispatch by pressing F9
nnoremap <F9> :wa<CR>:Dispatch<CR>

" Run rspec on the current file in Dispatch by pressing F10
nnoremap <F10> :w<CR>:Dispatch rspec %<CR>
"
" use jj to quickly escape to normal mode while typing <- AWESOME tip
inoremap jj <ESC>
