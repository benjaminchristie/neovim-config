vim.cmd(
[[
"{{{ Defaults (that most users want)
" Get the defaults that most users want.
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline
set hlsearch
set incsearch
syntax on
set showcmd
set relativenumber
set number
set nofoldenable
set nobackup
set signcolumn=number
"set nocompatible
set undofile
set ts=4 sw=4
let g:syntastic_auto_jump = 1
set clipboard+=unnamedplus

set splitright

" Search down subfolders
" Provides tab-completion for all file-related tasks
set path+=**
set wrap " set word wrap, good for markdown files
" Display all matching files when we tab complete
set wildmenu
set nosol
"}}}
"{{{ Keybindings (Lazily loaded)
" Various remappings for width and other
" imap kj <Esc>
" imap jk <Esc>
" Remap arrow keys
nnoremap <Up> <C-b>
nnoremap <Down> <C-f>
nnoremap <Left> gT
nnoremap <Right> gt
" Make seperated windows easier to change size
nnoremap `1 :5winc<<CR>
nnoremap `4 :5winc><CR>
nnoremap `2 :3winc+<CR>
nnoremap `3 :3winc-<CR>
" Adding functionality to making a pdf in a new view
" New tab
nnoremap ,t <Esc>:tabnew<CR> 
" Make Y behave like the rest of the capital letters
nnoremap Y y$

" LaTeX shortcuts for ease of use
"nnoremap <Space>CC :call TermToggle(12)<CR> <C-L> make -k -C `upsearch Makefile`
" Compilation command. Requires a Makefile nearby, but not in the current
" directory

nnoremap <C-c><C-c> :sp<bar>terminal<CR>i<C-l>make -k -C `upsearch Makefile`
nnoremap <C-c><C-k> :!pandoc <C-r>% -o <C-r>%.pdf<CR>
" nnoremap <C-c><C-k> :let @k=@%<CR>:terminal<CR>ipandoc <esc>"kp
"A-o <esc>"kpA.pdf

" nnoremap <silent> <C-c><C-k> :let @k=@%<CR>ipandoc <esc>$"kpA -o <esc>$"kpA.pdf
"Folding creation helper
"nnoremap zfc zf//} } }<CR> " since my custom pattern for a fold is {{{ ... }}}, this works well outside of typescript and json
nnoremap zs zMzO 
" close all folds except the current, which is opened fully
set foldmethod=marker
set foldmarker={{{,}}}

"}}}
"{{{ Helpful Functions
" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction
" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q <C-\><C-n>:q!<CR>

" Remove annoying vertical split thiccness
hi VertSplit cterm=none
if &t_Co > 2 || has("gui_running")
    " Switch on highlighting the last used search pattern.
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
    packadd! matchit
endif
"}}}
"{{{ Package Configuration
" Adding raven theme to startup
" let g:airline_theme='raven'
let g:airline_theme='base16_nord' " raven
let g:airline#extensions#tabline#enabled = 1
let g:airline_extensions = ['branch', 'whitespace']

" change runtime to accomadate ctrl-p package
" set runtimepath^=~/.vim/pack/dist/start/ctrlp.vim
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_working_path_mode = 'a'
" let g:ctrlp_show_hidden = 0
autocmd BufEnter *.launch :setlocal filetype=xml

" autoformat on save 
set tabstop=4
set shiftwidth=4
set expandtab    
" autocmd BufWritePost * execute "normal mtgg=G`t"

" remember folds
" augroup remember_folds
"     autocmd!
"     autocmd BufWinLeave * mkview
"     autocmd BufWinEnter * silent! loadview
" augroup END

" colorscheme Tomorrow-Night
hi Folded ctermbg=black

colorscheme tokyonight
" colorscheme for dark: 
" colorscheme Tomorrow-Night-Bright
" let g:airline_theme='raven' " raven
" c++ development stuff

" function! s:JbzCppMan()
"     let old_isk = &iskeyword
"     setl iskeyword+=:
"     let str = expand("<cword>")
"     let &l:iskeyword = old_isk
"     execute 'Man ' . str
" endfunction
" command! JbzCppMan :call s:JbzCppMan()

" au FileType cpp nnoremap <buffer>K :JbzCppMan<CR>

" function! s:JbzClangFormat(first, last)
"     let l:winview = winsaveview()
"     execute a:first . "," . a:last . "!clang-format"
"     call winrestview(l:winview)
" endfunction
" command! -range=% JbzClangFormat call <sid>JbzClangFormat (<line1>, <line2>)

" " Autoformatting with clang-format
" au FileType c,cpp nnoremap <buffer><leader>lf :<C-u>JbzClangFormat<CR>
" au FileType c,cpp vnoremap <buffer><leader>lf :JbzClangFormat<CR>

" syntax highlighting for files such as tex and md
" autocmd BufEnter,BufNewFile,BufRead,BufReadPost,BufWrite *.tex set syntax=context

" Telescope configuration 
nnoremap <C-p><C-p> <cmd>Telescope find_files<cr>
nnoremap <C-p>g    <cmd>Telescope live_grep<cr>
nnoremap <C-p>b    <cmd>Telescope buffers<cr>
nnoremap <C-p>h    <cmd>Telescope help_tags<cr>
autocmd User TelescopePreviewerLoaded setlocal wrap
command Lex NvimTreeFindFile
command Ex NvimTreeFocus

lua require('init')
" LaTeX Quality of Life
"
"let g:tex_fold_enabled=0
"let g:text_fold_use_default_envs=0
"}}}
]]
)
-- done with loading vim.cmd config
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true



