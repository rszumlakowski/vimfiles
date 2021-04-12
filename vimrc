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

" Running programs asynchronously. Despite the
" name, works with both vim and neovim.
Plug 'neomake/neomake'

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

" Allow yaml files to be folded
Plug 'digitalrounin/vim-yaml-folds'

" Hooks up neovim supports to vim-dispatch
if has('nvim')
  Plug 'radenling/vim-dispatch-neovim'
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

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" F8 to show the Tagbar window
nmap <F8> :TagbarToggle<CR>

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

" neomake sucks at highlighting
hi! link NeomakeWarningSign SignColumn
hi! link NeomakeWarning NeomakeMessageDefault

" Tell Vim Test to use NeoMake and Dispatch
let test#strategy='neomake'

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

" Compiler settings based on file types
autocmd BufRead,BufNewFile *.rb compiler bundle_exec_rspec
autocmd BufRead,BufNewFile *.rs compiler cargo

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

"""" ----- vvv COC settings vvv -----

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <F2> to trigger completion.
inoremap <silent><expr> <F2> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"""" ----- ^^^ COC settings ^^^ -----

