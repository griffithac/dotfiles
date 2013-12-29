syntax enable

set nocompatible " be iMproved
filetype on      " required!
color railscasts

set rtp+=~/.vim/bundle/vundle/
set ruler
set number
set list
set listchars=tab:▸\ ,eol:¬
set ts=2 sts=2 sw=2 expandtab
call vundle#rc()

" required! 
Bundle 'gmarik/vundle'

" My bundles here:

" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'ivalkeen/vim-simpledb'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-git'
Bundle 'vim-ruby/vim-ruby'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'

" non-GitHub repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on

imap jj <ESC>
imap >> <ESC>>>i  
imap << <ESC><<i
" This makes it so that all indentation commands are the same in all modes.
" Causes a problem with ranges in ruby.  You would have to slow type ..
imap ,, <ESC>v<i
imap .. <ESC>v>i
nmap ,, <<
nmap .. >>
vmap ,, <gv
vmap .. >gv

imap mg Michelle Griffith
imap ag Andrew Griffith
imap gii Griffith Industries, Inc.

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
autocmd BufWritePre *.py,*.js,*.coffee,*.rb,*.rake :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction
