" Author: congdv
" Date: 2017 - 08 - 28
" Don't put any lines in your vimrc that you don't understand.
" https://dougblack.io/words/a-good-vimrc.html

" Color {{{
" colorscheme badwolf
"set background=dark
set t_Co=256
syntax enable                         " enable syntax processing
" }}}
" Indentation {{{
set autoindent                        " use indentation of previous line
set smartindent                       " use intelligent indentation for C
" }}} // End Indentation

" Spaces & Tabs {{{
set tabstop=4                         " number of visual spaces per TAB
set softtabstop=4                     " number of spaces in tab when editing
set expandtab                         " tabs are spaces
set shiftwidth=4                      " when indenting with '>', use 4 spaces width
                                      " newline after braces will be 4 spaces
                                      " not 8 spaces
" }}} // End Spaces & Tabs

" Encoding {{{
set encoding=utf-8                    " The encoding displayed.
set fileencoding=utf-8                " The encoding written to file.
" }}}
" Leader {{{
let mapleader=","
" }}}

" UI Config {{{
set nocompatible                      " disable vi compatible
set number                            " show line numbers
set showcmd                           " show command in bottom bar
set cursorline                        " highlight current line
filetype plugin indent on             " load filetype-specific indent files
set showmatch                         " highlight matching [{()}]
"autocmd BufWritePre * :%s/\s\+$//e "automatically remove trailing whitespace
"autocmd BufReadPre,FileReadPre *.c,*.cpp,*.h :AirlineToggleWhitespace " Disable check trailing whitespace
" }}} // End UI Config

" Searching {{{
set incsearch                         " search as characters are entered
set hlsearch                          " highlight matches
nnoremap <leader><space> :nohlsearch<CR> " Turn off search highlight
" }}} // End Searching

" Swap file {{{
"set directory=~/.vim/swap
" }}}
" Movement {{{
" Move vertically by visual line
nnoremap j gj
nnoremap k gk
" Move to beginning/end of line
nnoremap B ^
nnoremap E $
" Move to next/previous blank line
nnoremap <C-j> }
nnoremap <C-k> {
" Move to next/previous word
nnoremap <C-h> b
nnoremap <C-l> w

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
" }}}
"
"https://github.com/junegunn/vim-plug
"
"" Vim Plug {{{
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
"Plug 'vim-scripts/c.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'bling/vim-airline'
"Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'yggdroot/indentline'
Plug 'scrooloose/syntastic'
call plug#end()
" }}} // End Vim Plug

" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>         " open NERDTree with Ctrl+n
" }}}  // End NERDTree

" YouCompleteMe Plugin {{{
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"  " Configuration for completion
let g:ycm_confirm_extra_conf = 1                               " Confirm extra configurate

let g:ycm_server_python_interpreter = '/usr/bin/python' " Choose python interpreter
nnoremap <leader>g :YcmCompleter GoTo<CR>               " Shortcut go declaration Ctr-o for back

" Error show
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1             " populate vims location list with new diagnostic data
let g:ycm_open_loclist_on_ycm_diags = 1
"nnoremap <leader>1 :lnext<CR>                                  " CR is enter, go to next errors
"nnoremap <leader>2 :lprevious<CR>                              " Go to previous errors
" }}} // End YouCompleteMe Plugin

" Ctags Plugin {{{
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>    " Ctrl + \: Open the definition in a newtab
"map <C-p> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>         " Alt + ] - Open the definition in a vertical split

" Auto generate ctags
"au BufWritePost *.py,*.c,*.cpp,*.h silent! !eval 'ctags -R -o newtags; mv newtags tags' &

" }}} // End Ctags

" Auto headers {{{
"autocmd bufnewfile *.c,*.cpp,*.h 0r ~/.vim/templates/c_header.tpl
"autocmd bufnewfile *.c,*.cpp,*.h exe "1," . 6 . "g/File :.*/s//File : " .expand("%")
"autocmd bufnewfile *.c,*.cpp,*.h exe "1," . 6 . "g/Date :.*/s//Date : " .strftime("%Y-%m-%d")
" }}} // End Auto headers

" Indent Line {{{
let g:indentLine_char = '┆'
" }}} // End Indent Line

" Autogroups {{{
augroup configgroup
        autocmd!
        autocmd BufEnter Makefile setlocal noexpandtab
        autocmd BufEnter *.sh setlocal tabstop=2
        autocmd BufEnter *.sh setlocal shiftwidth=2
        autocmd BufEnter *.sh setlocal softtabstop=2
"        autocmd BufWritePre *.py, *.txt, *.md, *.c, *.cpp
"                            \:call <SID>StripTrailingWhitespaces()
augroup END
" }}} // End Autogroups

" TMUX {{{
" allows currsor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else 
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" Cusstom Function {{{
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above
function! <SID>StripTrailingWhitespaces()
    " save last search and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l,c)
endfunction
" }}}
