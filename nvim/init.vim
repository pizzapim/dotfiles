" General settings.
set mouse=a
set clipboard+=unnamedplus
set expandtab
set smartindent
set signcolumn=yes
set conceallevel=0
set updatetime=100

" Auto-install vim-plug.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Install plugins.

call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'lervag/vimtex'
Plug 'airblade/vim-gitgutter'

call plug#end()

let g:completion_confirm_key = "<tab>"

" Theming.

let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = '0'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[3B;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[4B;2;%lu;%lu;%lum"
endif

colorscheme gruvbox
set background=dark

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Setup language servers.
lua << EOF

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- local completion = require('completion')
  -- completion.on_attach()
end

require'lspconfig'.clangd.setup{ on_attach=on_attach }

EOF

" Autocomplete on all buffers.
autocmd BufEnter * lua require'completion'.on_attach()

augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.xml let g:completion_trigger_character = ['<']
augroup end

" Popups from completion shows markdown errors, disable markdown parsing.
hi markdownError guifg=None guibg=None

" vimtex settings
let g:vimtex_compiler_latexmk = {
      \ 'continuous' : 1,
      \}
let g:vimtex_syntax_conceal_default=0

" Keybindings.
let mapleader = "\<Space>"
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-s> :DocumentSymbols<CR>
" File select, only git files if in git project.
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"
nnoremap <leader>p "*p
nnoremap <leader>y "+y
