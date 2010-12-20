" unite scripts with unite.vim

let s:source = {
\   'name' : 'step_definitions',
\ }

function! s:create_candidate(val)
    let matches = matchlist(a:val, '^\(.*\)\t\(.*\)\t\(.*\)$')

    if len(matches) == 0
        return {"word": "none"}
    endif
    return {
    \   "word": matches[1],
    \   "action__path": matches[2],
    \   "action__line": matches[3],
    \   "kind": "jump_list",
    \   "source": "step_definitions"
    \ }
endfunction

function! s:source.gather_candidates(args, context)
  let lines = split(system(g:unite_step_definitions_command), "\n")
  return filter(map(lines, 's:create_candidate(v:val)'), 'len(v:val) > 0')
endfunction

function! unite#sources#step_definitions#define()
  return [s:source]
endfunction

if !exists('g:unite_step_definitions_command')
  let g:unite_step_definitions_command = 'tsuridana-unite'
endif

