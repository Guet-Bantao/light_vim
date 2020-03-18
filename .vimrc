"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This vimrc is based on the vimrc by Amix - http://amix.dk/
" You can find the latest version on:
"       http://blog.csdn.net/easwy
"
" Maintainer:
" Version: 1.0
" Last Change: 18/07/19 09:17:57
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

" Platform
function! MySys()
   return "linux"
endfunction

set autochdir
"Sets how many lines of history VIM har to remember
set history=400

" Chinese
if MySys() == "windows"
   "set encoding=utf-8
   "set langmenu=zh_CN.UTF-8
   "language message zh_CN.UTF-8
   "set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1
endif

"Enable filetype plugin自动补全
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
set autoread

set clipboard+=unnamed " 共享外部剪贴板

"Have the mouse enabled all the time:
set mouse+=v
set mouse+=a

"Set mapleader
let mapleader="\<Space>"
let g:mapleader = "\<Space>"

"save last time you write place
autocmd BufReadPost *
      \ if line("'\"")>0&&line("'\"")<=line("$") |
      \exe "normal g'\"" |
        \ endif

"Fast saving
nmap <silent> <leader>ww :w<cr>
nmap <silent> <leader>wf :w!<cr>

"Fast quiting
nmap <silent> <leader>wq :wq<cr>
nmap <silent> <leader>qf :q!<cr>
nmap <silent> <leader>qq :q<cr>
nmap <silent> <leader>qa :qa<cr>

"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>

"Fast redraw
nmap <silent> <leader>rr :redraw!<cr>

" Switch to buffer according to file name
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

"Fast edit vimrc
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
    "Fast copying from linux
    func! CopyFromZ()
      autocmd! bufwritepost _vimrc
      exec 'split y:/.vimrc'
      exec 'normal 17G'
      exec 's/return "linux"/return "windows"/'
      exec 'w! ~/_vimrc'
      exec 'normal u'
      exec 'q'
    endfunc
    nnoremap <silent> <leader>uu :call CopyFromZ()<cr>:so ~/_vimrc<cr>
endif

" For windows version
if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set diffexpr=MyDiff()
    function! MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Set font
"if MySys() == "linux"
"  set gfn=Monospace\ 11
"endif

let g:vimrc_loaded = 1
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
    "Enable syntax hl
    syntax enable

    " color scheme
    if has("gui_running")
        set guioptions-=T
	set guioptions-=m
        set guioptions-=L
        set guioptions-=r
        colorscheme darkbule_my
	"hi normal guibg=#294d4a
    endif " has
endif " exists(...)

colorscheme elflord
"colorscheme monokai
set t_Co=256

"hilight function name
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions guifg=#7fd02e cterm=bold ctermfg=80 "函数蓝色80

syn match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
hi cClass guifg=#7fd02e cterm=bold ctermfg=yellow

hi Search term=standout ctermfg=0 ctermbg=3 "搜索黄色3
hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE "光标行
"hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
"hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE "行号
hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE "分隔线
hi MatchParen ctermfg=197 ctermbg=NONE cterm=underline guifg=#f92672 guibg=NONE gui=underline
hi Comment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE "注释
hi Conditional ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE "条件
hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#f8f8f2 guibg=#64645e gui=NONE

if &diff
  syntax off 
  "colorscheme desert
endif
"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=c<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

autocmd BufEnter * :syntax sync fromstart

"Highlight current
"if has("gui_running")
  set cursorline
  hi cursorline guibg=#333333
  hi CursorColumn guibg=#333333
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"set so=7

" Maximum window when GUI running
if has("gui_running")
  set lines=9999
  set columns=9999
endif

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"vim中对80字符的限制提示
"Show the colorcolumn
"set cc=80

"Change buffer - without saving
"set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>

"Ignore case when searching不区分大小写
"set ignorecase

"Include search
set incsearch

"Highlight search things
set hlsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
"set showmatch

set smarttab
"set lbr
"set tw=78

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai

"Smart indet
set si

"C-style indeting
set cindent

"Wrap lines
set wrap


""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2

function! CurDir()
   let curdir = substitute(getcwd(), '/home/', "~/", "g")
   return curdir
endfunction
"Format the statusline
"set statusline=\ %F%m%r%h\ %w\ \ PWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ %p
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ %=Line:\ %l,%c\ %p%%\ %{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\
"default use plugin ele_statusline.vim

"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

try
  set switchbuf=useopen
  set stal=1
catch
endtry

"Switch to current dir
map <silent> <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Bash like
cnoremap <C-A>    <Home>
cnoremap <C-E>    <End>
cnoremap <C-K>    <C-U>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=sesdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
"set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
"set fen
"set fdl=0
nmap <silent> <leader>zo zO
vmap <silent> <leader>zo zO


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noexpandtab
set shiftwidth=8
set tabstop=8
set softtabstop=8
"set listchars=tab:>-,trail:-
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

"map <leader>t2 :set shiftwidth=2<cr>
"map <leader>t4 :set shiftwidth=4<cr>
au FileType html,python,vim,javascript setl shiftwidth=2
"au FileType html,python,vim,javascript setl tabstop=2
au FileType java setl shiftwidth=4
"au FileType java setl tabstop=4
au FileType txt setl lbr
au FileType txt setl tw=78


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" options
set completeopt=menu
set complete-=u
set complete-=i

" Enable syntax
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \if &omnifunc == "" |
        \  setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  if MySys() == "linux"
    set csprg=/usr/bin/cscope
  else
    set csprg=cscope
  endif
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  "cs add /home/kernel/linux-4.9/cscope.out /home/kernel/linux-4.9
  set csverb
endif

"查找C语言符号，即查找函数名、宏、枚举值等出现的地方
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"查找调用本函数的函数
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"查找指定的字符串
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"查找egrep模式，相当于egrep功能，但查找速度快多了
nmap  <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"查找本文件，类似vim的find功能
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"查找包含本文件的文件
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"查找本函数调用的函数
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-LeftMouse> :tag <C-R>=expand("<cword>")<CR><CR>


""""""""""""""""""""""""""""""
" Super Tab
""""""""""""""""""""""""""""""
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:SuperTabDefaultCompletionType = "<C-P>"
"let g:SuperTabDefaultCompletionType = 0


""""""""""""""""""""""""""""""
" bufexplorer setting
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=1       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=0  " Open in new window.
let g:bufExplorerMaxHeight=30        " Max height
let g:bufExplorerDisableDefaultKeyMapping =1 " Do not disable default key mappings.
autocmd BufWinEnter \[Buf\ List\] setl nonumber
nnoremap <silent> <F9> :BufExplorer<CR>

""""""""""""""""""""""""""""""
" taglist setting
""""""""""""""""""""""""""""""
if MySys() == "windows"
    let Tlist_Ctags_Cmd = 'ctags'
elseif MySys() == "linux"
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Use_Right_Window = 1
let Tlist_Process_File_Always=1
let Tlist_Auto_Open = 1
let g:Tlist_WinWidth=28
let g:Tlist_GainFocus_On_ToggleOpen = 0
nmap <silent> <F7> :Tlist<cr>

""""""""""""""""""""""""""""""
" winmanager setting
""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout='FileExplorer'
let g:winManagerWidth = 23
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWindowLayout = "BufExplorer|FileExplorer"
let g:defaultExplorer = 1
let g:persistentBehaviour=1  "winmanager的窗口是最后一个窗口时，退出VIM
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
let g:AutoOpenWinManager = 1
nmap <silent> <leader>wm :WMToggle<cr>
autocmd BufWinEnter \[Buf\ List\] setl nonumber
nmap <silent> <F8> :WMToggle<cr>

""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 45
nmap <silent> <leader>fe :Sexplore!<cr>
nmap <silent> <F2> :Sexplore!<cr>

""""""""""""""""""""""""""""""
" LaTeX Suite things
""""""""""""""""""""""""""""""
set grepprg=grep\ -nH\ $*
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'


""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0
let g:LookupFile_UsingSpecializedTags = 1
let g:LookupFile_Bufs_LikeBufCmd = 0
let g:LookupFile_ignorecase = 1
let g:LookupFile_smartcase = 1
if filereadable("./filename.tags")
    let g:LookupFile_TagExpr = '$PWD . "/filename.tags"'
else
    let g:name_file=findfile("filename.tags", ".;")
    let g:LookupFile_TagExpr='g:name_file'
endif

nmap <silent> <leader>lk :LUTags<cr>
nmap <silent> <leader>ll :LUBufs<cr>
nmap <silent> <leader>lw :LUWalk<cr>

   " lookup file with ignore case
   function! LookupFile_IgnoreCaseFunc(pattern)
       let _tags = &tags
       try
           let &tags = eval(g:LookupFile_TagExpr)
           let newpattern = '\c' . a:pattern
           let tags = taglist(newpattern)
       catch
           echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
           return ""
       finally
           let &tags = _tags
       endtry

       " Show the matches for what is typed so far.
       let files = map(tags, 'v:val["filename"]')
       return files
   endfunction
   let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'


""""""""""""""""""""""""""""""
" vimgdb setting
""""""""""""""""""""""""""""""
"let g:vimgdb_debug_file = ""
"run macros/gdb_mappings.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   " Todo
   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   "au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim

   """"""""""""""""""""""""""""""
   " HTML related
   """"""""""""""""""""""""""""""
   " HTML entities - used by xml edit plugin
   let xml_use_xhtml = 1
   "let xml_no_auto_nesting = 1

   "To HTML
   let html_use_css = 1
   let html_number_lines = 0
   let use_xhtml = 1

   """""""""""""""""""""""""""""""
   " Vim section
   """""""""""""""""""""""""""""""
   autocmd FileType vim set nofen
   autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>

   """"""""""""""""""""""""""""""
   " HTML
   """""""""""""""""""""""""""""""
   au FileType html set ft=xml
   au FileType html set syntax=html


   """"""""""""""""""""""""""""""
   " C/C++
   """""""""""""""""""""""""""""""
   autocmd FileType c,cpp  map <buffer> <leader><space> :make<cr>
   "autocmd FileType c,cpp  setl foldmethod=syntax | setl fen

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Quickfix
"nmap <leader>cn :cn<cr>
"nmap <leader>cp :cp<cr>
"nmap <leader>cw :cw 10<cr>
"nmap <leader>cc :botright lw 10<cr>
"map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>

function! s:GetVisualSelection()
   let save_a = @a
   silent normal! gv"ay
   let v = @a
   let @a = save_a
   let var = escape(v, '\\/.$*')
   return var
endfunction

" Fast grep
nmap <silent> <leader>f :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>
vmap <silent> <leader>f :lv /<c-r>=<sid>GetVisualSelection()<cr>/ %<cr>:lw<cr>

" Fast diff
cmap @vd vertical diffsplit
set diffopt+=vertical

"Remove the Windows ^M
noremap <Leader>dm mmHmn:%s/<C-V><cr>//ge<cr>'nzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"see modify text
nmap <silent> <F4> :changes<cr>

"Remove indenting on empty lines
"map <F6> :%s/\s*$//g<cr>:noh<cr>''	"give up!! use ds command replace it!
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  nohl
  exe "normal `z"
endfunc

" do not automaticlly remove trailing whitespace
"autocmd BufWrite *.[ch] :call DeleteTrailingWS()
"autocmd BufWrite *.cc :call DeleteTrailingWS()
"autocmd BufWrite *.txt :call DeleteTrailingWS()
nmap <silent> <leader>ds :call DeleteTrailingWS()<cr>:w<cr>
nmap <silent> <leader>ds! :call DeleteTrailingWS()<cr>:w!<cr>

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"Super select all
nmap <C-a> ggVGY

"Fast Ex command
nnoremap ; :

"For mark move
nnoremap <leader>' '

"Fast copy
nnoremap ' "

"A function that inserts links & anchors on a TOhtml export.
" Notice:
" Syntax used is:
" Link
" Anchor
function! SmartTOHtml()
TOhtml
try
    %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
    %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
    %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
catch
    endtry
    exe ":write!"
    exe ":bd"
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"user add ctag
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set tags=/home/kernel/linux-4.9/tags;
set tags=tags;
set autochdir

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mark as loaded
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set list

nmap <TAB> :bp<cr>
