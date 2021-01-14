call g:plug#begin()
  " theme
  Plug 'gosukiwi/vim-atom-dark'
  Plug 'joshdick/onedark.vim'
  Plug 'zacanger/angr.vim'
  Plug 'morhetz/gruvbox'
  Plug 'caglartoklu/borlandp.vim'
  " auto detect indent
  Plug 'tpope/vim-sleuth'
  " Project exp
  Plug 'ctrlpvim/ctrlp.vim'
  " LSP and completions
  Plug 'JuliaEditorSupport/julia-vim'
  Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
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
let g:gruvbox_contrast_dark = 'hard'
syntax on
" set gutter always on
set signcolumn=yes
set bg=dark
set guifont=screen
set wildmode=longest,list,full
set termguicolors
set cursorline
set cursorcolumn
set nowrap
set showcmd
colorscheme atom-dark

" deoplete
let g:deoplete#enable_at_startup = 1
" julia
let g:default_julia_version = '1.0'

" language server
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_diagnosticsSignsMax = v:null
let g:LanguageClient_useVirtualText = "No"
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
\   'python': ['pyls'],
\   'rust': ['/home/madura/Downloads/rust-analyzer-linux'],
\ }

function! HeaderToggle() " bang for overwrite when saving vimrc
let file_path = expand("%")
let file_name = expand("%<")
let extension = split(file_path, '\.')[-1] " '\.' is how you really split on dot
let err_msg = "There is no file "

if extension == "c" || extension == "cpp"
    let next_file = join([file_name, ".h"], "")

    if filereadable(next_file)
    :e %<.h
    else
        echo join([err_msg, next_file], "")
    endif
elseif extension == "h"
    let next_file = join([file_name, ".c"], "")

    if filereadable(next_file)
        :e %<.c
    else
        let next_file = join([file_name, ".cpp"], "")
        if filereadable(next_file)
            :e %<.cpp 
        else
            echo join([err_msg, next_file], "")
        endif
    endif
endif
endfunction

" switch bufs without save
set hidden
nnoremap <silent> <F4> :call HeaderToggle()<CR>
nnoremap <leader>v <cmd>CHADopen<cr>
nnoremap <leader>c :call LanguageClient_contextMenu()<CR>
nnoremap <leader>d :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F8> :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>r :call LanguageClient_textDocument_rename()<CR>
