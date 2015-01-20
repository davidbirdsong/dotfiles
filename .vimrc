" set rtp+=$GOPATH/src/github.com/glang/lint/misc/vim


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" The following are examples of different formats supported.
" Keep bundle commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-rails.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
" scripts not on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"
Plugin 'fatih/vim-go'
Plugin 'git@github.com:Valloric/YouCompleteMe.git'
Plugin 'https://github.com/SirVer/ultisnips'
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"


filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
"Plugin
  " | PluginInstall(!), VundleInstall(!)
  " | PluginUpdate, VundleUpdate
  " | PluginSearch(!), VundleSearch(!)
  " | PluginClean(!), VundleClean(!)
  " | PluginList
set nocompatible              " be iMproved, required
filetype plugin on
colorscheme elflord
filetype off                " required
syntax on
set number
set list
set listchars=tab:⋅\ ,eol:¬

