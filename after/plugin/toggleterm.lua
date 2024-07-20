
local Terminal = require("toggleterm.terminal").Terminal

vim.keymap.set('t', '<A-q>', '<C-\\><C-n>')

--lazygit terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, close_on_exit= true })
function LAZYGIT_TOGGLE()
	lazygit:toggle()
end
vim.keymap.set({'n', 't','i'}, '<A-t>l', ':lua LAZYGIT_TOGGLE()<CR>', { silent = true})

--rebar3 shell
local rebarshell_main_cmd = "rebar3 shell --sname main_node --setcookie cookie"
local rebarshell_slave_cmd = "rebar3 shell --sname slave_node --setcookie cookie"

local rebarshell = Terminal:new({ cmd = rebarshell_main_cmd, hidden = true })
function REBAR_SHELL_TOGGLE()
	rebarshell:toggle()
end
vim.keymap.set({'n','t','i'}, '<A-t>s', ':lua REBAR_SHELL_TOGGLE()<CR>', { silent = true})

--rebar3 ct
local rebarct = Terminal:new({ cmd = "rebar3 ct --sname main_node --setcookie cookie", hidden = true })
function REBAR_CT_TOGGLE()
	rebarct:toggle()
end
vim.keymap.set({'n','i','t'}, '<A-t>c', ':lua REBAR_CT_TOGGLE()<CR>', {  silent = true })

-- rebar3 ct case
function REBAR_CT_CASE(suite, case)
	local this_cmd =  "rebar3 ct --sname main_node --setcookie cookie --suite " .. suite .. " --case " .. case
	Terminal:new({ cmd = this_cmd, hidden = true }):toggle()
end
vim.keymap.set({'i','n','t'}, '<A-t>o', ':lua REBAR_CT_CASE(vim.fn.expand("%:t:r"), vim.fn.expand("<cword>"))<CR>', {  silent = true })


-- rebar3 shell for more shells at once	
local rbs_down_2 = Terminal:new({cmd = rebarshell_slave_cmd, direction = "horizontal",   hidden = true})
function RSSLAVE()
	rbs_down_2:toggle()
end

local rbs_down_1 = Terminal:new({cmd = rebarshell_main_cmd, direction = "horizontal",   hidden = true})
function RSMAIN()
	rbs_down_1:toggle()
end
function RS2SHELLS()
	RSSLAVE()
	RSMAIN()
end

local erlang_fmt = Terminal:new({ cmd = "rebar3 format",
								hidden = true,
								close_on_exit= true,
								on_close = function(term)
									vim.defer_fn(function()
										vim.cmd("e!")
									end, 50)
								end})
function ERLANG_FMT()
	erlang_fmt:toggle()
end
vim.keymap.set('n', '<A-t>fe', ':lua ERLANG_FMT()<CR>', { silent = true})


vim.keymap.set({'n', 't','i'}, '<A-t>~', ':lua RS2SHELLS()<CR>', { silent = true})

vim.keymap.set({'n', 't','i'}, '<A-t>S', ':lua RSMAIN()<CR>', { silent = true})

vim.keymap.set({'n', 't','i'}, '<A-t>m', ':lua RSSLAVE()<CR>', { silent = true})
