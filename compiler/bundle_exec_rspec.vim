" Vim compiler file
"
" COPIED BY ROB SZ!
"
" original:
" Language:		RSpec
" Maintainer:		Tim Pope <vimNOSPAM@tpope.org>
" URL:			https://github.com/vim-ruby/vim-ruby
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>
" Last Change:		2018 Aug 07

if exists("current_compiler")
  finish
endif
let current_compiler = "bundle_exec_rspec"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=bundle\ exec\ rspec

CompilerSet errorformat=
    \%f:%l:\ %tarning:\ %m,
    \%E%.%#:in\ `load':\ %f:%l:%m,
    \%E%f:%l:in\ `%*[^']':\ %m,
    \%-Z\ \ \ \ \ %\\+\#\ %f:%l:%.%#,
    \%E\ \ \ \ \ Failure/Error:\ %m,
    \%E\ \ \ \ \ Failure/Error:,
    \%C\ \ \ \ \ %m,
    \%C%\\s%#,
    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
