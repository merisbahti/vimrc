"set nocompatible
syntax on
filetype plugin indent on
set number

" set tab rules
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab

set clipboard=unnamed
" Smart copying in terminal
set mouse+=a
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" insert mode - line
"let &t_SI .= "\<Esc>[5 q"
""replace mode - underline
""let &t_SR .= "\<Esc>[4 q"
""common - block
"let &t_EI .= "\<Esc>[3 q"

set vb t_vb=






let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

" Vundle plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Shougo/vimfiler.vim'

Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

if has('gui_running')
  set guifont=Menlo:h15
  colorscheme solarized
endif

" Explorer like NERDTree
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'
nnoremap <space>f :VimFiler -toggle<CR>

" EasyAlign stuff
" From visual mode, select portion to align, press enter then space
vnoremap <silent> <Enter> :EasyAlign<cr>

" Rebind leader key
"let mapleader = ","

" Buffered tab bindings
nnoremap <space>h  :tabfirst<CR>
nnoremap <space>k  :tabnext<CR>
nnoremap <space>j  :tabprev<CR>
nnoremap <space>l  :tablast<CR>
nnoremap <space>t  :tabedit<Space>
nnoremap <space>n  :tabnew<CR>
nnoremap <space>m  :tabm<Space>
nnoremap <space>d  :tabclose<CR>

" Unite settings
let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10
try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
catch
endtry

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
    imap <silent><buffer><expr> <C-x> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

" opening files
nnoremap <space><space> :<C-u>Unite buffer file_rec<cr>
nnoremap <space>r <Plug>(unite_restart)
" switching buffers
nnoremap <space>s :Unite -quick-match buffer<cr>

" fix whitespaec marking at end of file
let g:extra_whitespace_ignored_filetypes = ['unite']


