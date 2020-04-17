call g:plug#begin()
  " theme
  Plug 'gosukiwi/vim-atom-dark'
  Plug 'joshdick/onedark.vim'
  Plug 'zacanger/angr.vim'
  " auto detect indent
  Plug 'tpope/vim-sleuth'
  " Project exp
  Plug 'ctrlpvim/ctrlp.vim'
  " LSP and completions
  Plug 'JuliaEditorSupport/julia-vim'
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

  " IMPORTANT: :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect

  " NOTE: you need to install completion sources to get completions. Check
  " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
call g:plug#end()
" set up theme
syntax on
set wildmode=longest,list,full
set termguicolors
set cursorline
set cursorcolumn
colorscheme angr
" deoplete
let g:deoplete#enable_at_startup = 1
" julia
let g:default_julia_version = '1.0'

" language server
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_diagnosticsSignsMax = 0
"let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {
\   'julia': ['/home/madura/Downloads/julia-1.0.5/bin/julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       debug = false; 
\       
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
\       server.runlinter = false;
\       run(server);
\   '],
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\   'python': ['pyls']
\ }
" switch bufs without save
set hidden

nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <F9> :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F8> :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
