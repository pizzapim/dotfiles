"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""GLOBAL SETTINGS"""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""VIM SETTINGS""""""""""""""""""

let mapleader = "\<Space>"

filetype plugin on

set nocompatible
set backspace=2
set hidden
set hid
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set termguicolors
set scrolloff=12
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set number
set colorcolumn=80

" Disable syntax in MarkDown files
autocmd! bufreadpost *.md set syntax=off
" Set tab length for C
autocmd Filetype c setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" Set tab length for JavaScript
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" Remove whitespace on save
autocmd BufWritePre * %s/\s\+$//e

""""""""""""""""VIM KEYBINDINGS""""""""""""""""""

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer keybindings
map <Leader>bn :bn<cr>
map <Leader>bp :bp<cr>
map <Leader>bd :bd<cr>

" Tab keybindings
map tn :tabn<cr>
map tp :tabp<cr>
map td :tabd<cr>

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

""""""""""""""""PLUGINS""""""""""""""""""

" Download plug.vim if it is not installed
if empty(glob('~/.vim/autoload/plug.vim'))
 silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" File browser
Plug 'scrooloose/nerdtree'
" Show git edits in sign column
Plug 'airblade/vim-gitgutter'
" Git commands inside Vim
Plug 'tpope/vim-fugitive'
" Easily comment lines out
Plug 'tpope/vim-commentary'
" Base FZF wrapper for Vim
Plug '~/.fzf'
" Extra useful implementations of FZF
Plug 'junegunn/fzf.vim'
" Simple status line
Plug 'liuchengxu/eleline.vim'
" Indentation indication
Plug 'Yggdroot/indentLine'
" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Handy Latex features
Plug 'lervag/vimtex'
" Personal knowledge base
Plug 'vimwiki/vimwiki'
" Gruvbox theme
Plug 'morhetz/gruvbox'

" Always do this one last:
" Fancy icons in nerdtree (needs patched font)
Plug 'ryanoasis/vim-devicons'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""PLUGIN SETTINGS"""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""INDENTLINE"""""""""""""""""

" Hide formatted code when cursor is on line
let g:indentLine_setConceal = 2
let g:indentLine_concealcursor = ""
let g:indentLine_char = "┊"

"""""""""""""""VIMTEX"""""""""""""""""

map <Leader>lc :VimtexCompile<CR>

"""""""""""""""FZF"""""""""""""""""

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
 \ 'bg':      ['bg', 'Normal'],
 \ 'hl':      ['fg', 'Comment'],
 \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
 \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
 \ 'hl+':     ['fg', 'Statement'],
 \ 'info':    ['fg', 'PreProc'],
 \ 'border':  ['fg', 'Ignore'],
 \ 'prompt':  ['fg', 'Conditional'],
 \ 'pointer': ['fg', 'Exception'],
 \ 'marker':  ['fg', 'Keyword'],
 \ 'spinner': ['fg', 'Label'],
 \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'down': '~60%' }

nmap <c-p> :Files<CR>
nmap <leader>bl :Buffers<CR>

"""""""""""""""VIMWIKI"""""""""""""""""

map <Leader>wo :Vimwiki2HTMLBrowse<CR>
map <Leader>wc :Vimwiki2HTML<CR>

let wiki_school = {}
let wiki_school.path = '~/vimwiki/school/'

let wiki_keys = {}
let wiki_keys.path = '~/vimwiki/keys/'

let g:vimwiki_list = [wiki_school, wiki_keys]

"""""""""""""""ELELINE"""""""""""""""""

let g:eleline_slim = 1

"""""""""""""""GRUVBOX"""""""""""""""""

let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
set background=dark

colorscheme gruvbox

"""""""""""""""NERDTREE"""""""""""""""""

" Open nerdtree with shortcut
map <C-e> :NERDTreeToggle<CR>

"""""""""""""""COC"""""""""""""""""

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

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

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

let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-prettier'
  \ ]

command! -nargs=0 Prettier :CocCommand prettier.formatFile
