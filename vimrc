" This configuration applies to both vim and neovim.

" TODO: Convert this file into a LUA script
" TODO: Add the 'oil' file manager (https://github.com/stevearc/oil.nvim)

" Plug for plugins
call plug#begin('~/.vim/plugged')

" Git Commands
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

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

" software caps lock
Plug 'tpope/vim-capslock'

" fzf (fuzzy find) integration
Plug 'junegunn/fzf'

" ctrl-p file finder
Plug 'ctrlpvim/ctrlp.vim'

" Searching with ripgrep
Plug 'jremmen/vim-ripgrep'

" the git gutter for changes
Plug 'airblade/vim-gitgutter'

" Git log viewer
Plug 'rbong/vim-flog'

" colors
Plug 'chriskempson/base16-vim'

" run tests from within vim
Plug 'janko-m/vim-test'

" Easy substitution of text
Plug 'svermeulen/vim-subversive'

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
Plug 'mg979/vim-visual-multi'

" Tagbar plugin
Plug 'majutsushi/tagbar'

" Match up plugin
Plug 'andymass/vim-matchup'

" Dev icons
Plug 'ryanoasis/vim-devicons'

" Align text plugin
Plug 'junegunn/vim-easy-align'

" TOML file format plugin
Plug 'cespare/vim-toml'

" Rust plugin for vim
Plug 'rust-lang/rust.vim'

" Show vertical lines on indents (good for YAML)
Plug 'Yggdroot/indentLine'

" Alternate YAML plugin. Fixes the syntax highlighting in embedded documents
" in YAML files.
Plug 'stephpy/vim-yaml'

Plug 'Einenlum/yaml-revealer'

" Golang programming
Plug 'fatih/vim-go'

" Makes splitting and joining lines of code easier
Plug 'AndrewRadev/splitjoin.vim'

" Terraform syntax and command
Plug 'hashivim/vim-terraform'

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
set softtabstop=2 tabstop=2 shiftwidth=2 expandtab
set nowrap
set autowrite
set cursorline

" Make it easier to open filenames with 'gf'
set includeexpr=substitute(v:fname,'ci/','./','')
" set includeexpr=substitute(v:fname,'repo/','./','')

" Remap the leader key
let mapleader = ','

" configure the invisible chars
set listchars=trail:.,extends:#,nbsp:.

" BufOnly command to close all buffers except the only one
command! BufOnly execute '%bdelete|edit #|normal `"'

" Strips escape sequences and ^M characters from file
command! Strip execute '%s/\%x1b\[[0-9;]*m\|//g'

" F7 to show the Tagbar window
nnoremap <F7> :TagbarToggle<CR>

" Make YAML Great Again
if has("autocmd")
  autocmd FileType yaml setlocal indentexpr=
endif

" Markdown textwidth
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.markdown textwidth=80

" FZF plugin mappings
" FZF with the list of files managed by git
noremap <c-s> :call fzf#run(fzf#wrap({'source': 'git ls-files', 'down': '50%'}))<cr>

" CtrlP settings
let g:ctrlp_max_files=20000
nmap <C-L> :CtrlPMRU<CR>
nmap <C-Q> :CtrlPTag<CR>

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|tmp|log|node_modules|bin|vendor|target)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

let g:ctrlp_extensions = ['tag']

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
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gg :GBrowse<cr>
nnoremap <leader>gl :Gclog<cr>
nnoremap <leader>gpr :Git pull --rebase<cr>
nnoremap <leader>gps :Git push origin head<cr>

" tap-cves mappings
command! TapCveView read !tap-cves triage <C-r>"

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
end

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
noremap <silent> <leader>v :tabedit $HOME/.vim/vimrc<CR>

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

" use jj to quickly escape to normal mode while typing <- AWESOME tip
inoremap jj <ESC>

" Spell language English (Canadian)
set spelllang=en_ca

let g:go_highlight_function_calls = 1

" Compiler settings based on file types
if has("autocmd")
  autocmd BufRead,BufNewFile *.rb compiler bundle_exec_rspec
  autocmd BufRead,BufNewFile *.rs compiler cargo
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit') " vim-go plugin
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit') " vim-go plugin
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split') " vim-go plugin
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe') " vim-go plugin
  autocmd Filetype go nnoremap <F3> :wa<CR>:GoDecls<CR>
  autocmd Filetype go nnoremap <F4> :wa<CR>:GoDeclsDir<CR>
  autocmd Filetype go nnoremap <F5> :wa<CR>:GoTest!<CR>
  autocmd Filetype go nnoremap <F6> :wa<CR>:GoTestFunc!<CR>
  autocmd Filetype go GoBuildTags mage
  autocmd BufWritePost *.go silent! !ctags -R --languages=go --exclude=log --exclude=tmp &
  autocmd BufWritePost .vimrc source $HOME/.vim/vimrc<CR>
endif


" Starts deoplete at startup
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#option('omni_patterns', {
        \ 'go': '[^. *\t]\.\w*',
        \})
end

" Airline statusbar settings
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Search customization
let g:rg_highlight="true"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Mouse settings
set mouse=nv

" Disable indent line plugin for help and terminal files
let g:indentLine_bufTypeExclude = ['help', 'terminal']

" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" matchup settings
let g:matchup_matchparen_offscreen = { 'method': 'popup' }

" search for a YAML key
nnoremap <leader>y :call SearchYamlKey()<CR>
