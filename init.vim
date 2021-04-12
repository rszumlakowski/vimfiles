" This file is the configuration file for neovim, however, all it
" does is load the configuration file for vim itself.  That way,
" I only need to maintain one file (vimrc).

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vim/vimrc
