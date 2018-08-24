set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ntpeters/vim-better-whitespace'
Plugin 'fatih/vim-go'

" all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

set tabstop=4
set expandtab
set autoindent
set shiftwidth=4
set ruler
set number
set backspace=indent,eol,start
set visualbell
set background=dark
set hlsearch

" remove autoindent for C++ access specifiers
set cinoptions+=g0

set encoding=utf-8

" remove trailing whitespace on save
autocmd BufWritePre <buffer> :StripWhitespace

