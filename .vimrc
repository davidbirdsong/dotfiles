call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
"
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/vim-easymotion'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'fatih/vim-go'
Plug 'L9'
Plug 'FuzzyFinder'
Plug 'whatyouhide/vim-gotham'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'bling/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'stephpy/vim-yaml'
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

Plug 'majutsushi/tagbar'
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
    \}

set nocompatible              " be iMproved, required
filetype plugin on
filetype off                " required
syntax on
set number
set list
set listchars=tab:⋅\ ,eol:¬
set cursorline
set ruler

call plug#end()
