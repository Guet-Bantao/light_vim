" MIT License. Copyright (c) 2013-2020 Bailey Ling et al.
" vim: et ts=2 sts=2 sw=2

scriptencoding utf-8

let s:loaded_ext = []
let s:ext = {}
let s:ext._theme_funcrefs = []

function! s:ext.add_statusline_func(name) dict
  call airline#add_statusline_func(a:name)
endfunction
function! s:ext.add_statusline_funcref(function) dict
  call airline#add_statusline_funcref(a:function)
endfunction
function! s:ext.add_inactive_statusline_func(name) dict
  call airline#add_inactive_statusline_func(a:name)
endfunction
function! s:ext.add_theme_func(name) dict
  call add(self._theme_funcrefs, function(a:name))
endfunction

let s:script_path = tolower(resolve(expand('<sfile>:p:h')))

let s:filetype_overrides = {
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
      \ }

if get(g:, 'airline#extensions#nerdtree_statusline', 1)
  let s:filetype_overrides['nerdtree'] = [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ]
else
  let s:filetype_overrides['nerdtree'] = ['NERDTree', '']
endif

let s:filetype_regex_overrides = {}

function! s:check_defined_section(name)
  if !exists('w:airline_section_{a:name}')
    let w:airline_section_{a:name} = g:airline_section_{a:name}
  endif
endfunction

function! airline#extensions#append_to_section(name, value)
  call <sid>check_defined_section(a:name)
  let w:airline_section_{a:name} .= a:value
endfunction

function! airline#extensions#prepend_to_section(name, value)
  call <sid>check_defined_section(a:name)
  let w:airline_section_{a:name} = a:value . w:airline_section_{a:name}
endfunction

function! airline#extensions#apply_left_override(section1, section2)
  let w:airline_section_a = a:section1
  let w:airline_section_b = a:section2
  let w:airline_section_c = airline#section#create(['readonly'])
  let w:airline_render_left = 1
  let w:airline_render_right = 0
endfunction

function! airline#extensions#apply(...)
  let filetype_overrides = get(s:, 'filetype_overrides', {})
  call extend(filetype_overrides, get(g:, 'airline_filetype_overrides', {}), 'force')

  if s:is_excluded_window()
    return -1
  endif

  if &buftype == 'terminal'
    let w:airline_section_x = ''
    let w:airline_section_y = ''
  endif

  if &previewwindow && empty(get(w:, 'airline_section_a', ''))
    let w:airline_section_a = 'Preview'
    let w:airline_section_b = ''
    let w:airline_section_c = bufname(winbufnr(winnr()))
  endif

  if has_key(filetype_overrides, &ft) &&
        \ ((&filetype == 'help' && &buftype == 'help') || &filetype !~ 'help')
    " for help files only override it, if the buftype is also of type 'help',
    " else it would trigger when editing Vim help files
    let args = filetype_overrides[&ft]
    call airline#extensions#apply_left_override(args[0], args[1])
  endif

  if &buftype == 'help'
    let w:airline_section_x = ''
    let w:airline_section_y = ''
    let w:airline_render_right = 1
  endif

  for item in items(s:filetype_regex_overrides)
    if match(&ft, item[0]) >= 0
      call airline#extensions#apply_left_override(item[1][0], item[1][1])
    endif
  endfor
endfunction

function! s:is_excluded_window()
  for matchft in g:airline_exclude_filetypes
    if matchft ==# &ft
      return 1
    endif
  endfor

  for matchw in g:airline_exclude_filenames
    if matchstr(expand('%'), matchw) ==# matchw
      return 1
    endif
  endfor

  if g:airline_exclude_preview && &previewwindow
    return 1
  endif

  return 0
endfunction

function! airline#extensions#load_theme()
  call airline#util#exec_funcrefs(s:ext._theme_funcrefs, g:airline#themes#{g:airline_theme}#palette)
endfunction

function! airline#extensions#load()
  let s:loaded_ext = []

  if exists('g:airline_extensions')
    for ext in g:airline_extensions
      try
        call airline#extensions#{ext}#init(s:ext)
      catch /^Vim\%((\a\+)\)\=:E117/	" E117, function does not exist
        call airline#util#warning("Extension '".ext."' not installed, ignoring!")
        continue
      endtry
      call add(s:loaded_ext, ext)
    endfor
    return
  endif

  if get(g:, 'loaded_ctrlp', 0)
    call airline#extensions#ctrlp#init(s:ext)
    call add(s:loaded_ext, 'ctrlp')
  endif

  if get(g:, 'airline#extensions#branch#enabled', 1) && (
          \ airline#util#has_fugitive() ||
          \ airline#util#has_gina() ||
          \ airline#util#has_lawrencium() ||
          \ airline#util#has_vcscommand() ||
          \ airline#util#has_custom_scm())
    call airline#extensions#branch#init(s:ext)
    call add(s:loaded_ext, 'branch')
  endif

  if get(g:, 'airline#extensions#bufferline#enabled', 1)
        \ && exists('*bufferline#get_status_string')
    call airline#extensions#bufferline#init(s:ext)
    call add(s:loaded_ext, 'bufferline')
  endif

  if get(g:, 'airline#extensions#tabline#enabled', 0)
    call airline#extensions#tabline#init(s:ext)
    call add(s:loaded_ext, 'tabline')
  endif

endfunction

function! airline#extensions#get_loaded_extensions()
  return s:loaded_ext
endfunction
