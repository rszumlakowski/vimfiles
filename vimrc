" Rob Szumlakowski's nifty .vimrc file
"

syntax on

" allow filetype plugins
filetype plugin on

" allow indent plugins
filetype indent on

" don't care about being compatible with vi
set nocompatible

" Robbie prefers the darker colours, but comments need to be brighter
highlight Comment ctermfg=blue term=bold

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Always set autoindenting on
set autoindent

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4	

" Set the position of the tags file
"set tags=./tags,./../tags,./../../tags,./../../../tags,tags
set tags=./tags

" Don't wrap lines at the edge of the screen
set nowrap

" Turn on incremental searching
set incsearch

" Do ignore case during searches
set noignorecase

" The bottom window doesn't get a status line if it's the only window
set laststatus=1

" Show the matching bracket for the last ')'
set showmatch

" Allow backspacing over everything in insert mode
set backspace=2

" Always show the cursor position
set ruler

" Don't changes the sizes of existing windows when opening
" or closing new ones
set noequalalways

"" Turn on the 'Man blahblah' command
"source $VIMRUNTIME/ftplugin/man.vim

" Map F1 F2 and F3 to page through open buffers
noremap <F1> :bprevious!<CR>
noremap <F2> :bnext!<CR>
"noremap <F3> :brewind!<CR>

" Map F4 to refresh the current tags file
"noremap <F4> :!(cd %:p:h;ctags *.[chC];ctags *.cc)&

" Let vim makes typing in multiline comments
" easier
set formatoptions+=roc

" Turn on highlighting of search results
set hlsearch

"make editting lots of files at once easier
"by mapping ctrl+j and k to jump through windows
"quickly and make them big.  at the same time, decrease
"the minimum window height since the filename is
"often all we really need to see...
noremap <C-J> <C-W>j<C-W>_ 
noremap <C-K> <C-W>k<C-W>_
set winminheight=0

" Pressing leader u creates an underline under the current line
noremap <silent> <Leader>u Yp:s/./-/g<CR>:noh<CR>j
noh

" Press shift+up or shift+down to swap the current
" line with the line above or below.
function! MySwapUp() 
  if ( line( '.' ) > 1 ) 
    let cur_col = virtcol(".") 
    if ( line( '.' ) == line( '$' ) ) 
      normal ddP 
    else 
      normal ddkP 
    endif 
    execute "normal " . cur_col . "|" 
  endif 
endfunction 

function! MySwapDown() 
  if ( line( '.' ) < line( '$' ) ) 
    let cur_col = virtcol(".") 
    normal ddp 
    execute "normal " . cur_col . "|" 
  endif 
endfunction 

noremap <silent> <S-Up> :call MySwapUp()<CR> 
noremap <silent> <S-Down> :call MySwapDown()<CR>

" Press <leader> r to open vimrc (this file, even!)
noremap <silent> <leader>r :split ~/.vimrc<CR>

" Press <leader> R to source vimrc
noremap <silent> <leader>R :source ~/.vimrc<CR>

" save befores before 'make'ing
set autowrite

" save and source the current file
map <Leader>S :w<CR>:execute "source ".expand("%:p")<CR>

" Set up things to match on
set matchpairs=(:),{:},[:],<:>

" we don't want vim to treat numbers as in octal format
" when using the ctrl-a and ctrl-x commands
set nrformats=hex

" set the OpenURL command to open the given URL in the default browser
command! -bar -nargs=1 OpenURL :!open <args>

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Set up Latex Suite to use Preview as the PDF viewing program
let Tex_ViewRuleComplete_pdf = '/usr/bin/open -a Preview $*.pdf' 

" Recognize groovy files
au BufNewFile,BufRead *.groovy  setf groovy
au BufNewFile,BufRead *.gradle  setf groovy
