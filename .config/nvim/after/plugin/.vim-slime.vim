" for all buffers
let g:slime_target = "tmux"

let g:slime_bracketed_paste = 1

let g:slime_paste_file = expand("$HOME/.slime_paste")
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}

vnoremap <leader>s :SlimeSend<CR>
nnoremap <leader>ss :SlimeSendCurrentLine<CR>
