require("toggleterm").setup({
	open_mapping = [[<A-t>t]],
	insert_mappings = true,
	terminal_mappings = true,
	direction = "float",
	close_on_exit = false,
	config = true
})


local Terminal = require("toggleterm.terminal").Terminal

vim.keymap.set('t', '<A-q>', '<C-\\><C-n>') -- exit to normal mode in terminal

--lazygit terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true,display_name = "lazygit", close_on_exit = true })
function LAZYGIT_TOGGLE()
	lazygit:toggle()
end
vim.keymap.set({ 'n', 't', 'i' }, '<A-t>l', ':lua LAZYGIT_TOGGLE()<CR>', { silent = true })

--rebar3 shell
function REBAR_SHELL(sname)
	local rebarshell = "rebar3 shell --sname " .. sname .. " --setcookie cookie"
	local term_name = "rebar3 shell " .. sname
 	local ShellTerminal = Terminal:new({ cmd = rebarshell,  display_name = term_name, hidden = true })
	return ShellTerminal

end

local opened_shell = 0
local main_shell = "null"

function REBAR_SHELL_TOGGLE()
	if opened_shell == 0  then
		opened_shell = 1
		 main_shell = REBAR_SHELL("main_node")
	end
	main_shell:toggle()
end
function REBAR_SHELL_TOGGLE_INPUT()
	local sname = vim.fn.input("Enter sname for shell")
	REBAR_SHELL(sname):toggle()
end

vim.keymap.set({ 'n', 't', 'i' }, '<A-t>s', ':lua REBAR_SHELL_TOGGLE()<CR>', { silent = true })
vim.keymap.set({ 'n', 't', 'i' }, '<A-t>ns', ':lua REBAR_SHELL_TOGGLE_INPUT()<CR>', { silent = true })

--rebar3 ct
local rebarct = Terminal:new({ cmd = "rebar3 ct --sname main_node --setcookie cookie", display_name = "rebar3 ct", hidden = true })
function REBAR_CT_TOGGLE()
	rebarct:toggle()
end

vim.keymap.set({ 'n', 'i', 't' }, '<A-t>c', ':lua REBAR_CT_TOGGLE()<CR>', { silent = true })

-- rebar3 ct case
function REBAR_CT_CASE(suite, case, sname)
	local this_cmd = "rebar3 ct --sname " .. sname .. " --setcookie cookie --suite " .. suite .. " --case " .. case
	Terminal:new({ cmd = this_cmd, hidden = true, display_name = "rebar3 ct case " .. case .. " " .. sname }):toggle()
end

function REBAR_CT_CASE_TOGGLE()
	REBAR_CT_CASE(vim.fn.expand("%:t:r"), vim.fn.expand("<cword>"), "test_node")
end
function REBAR_CT_CASE_TOGGLE_INPUT()
	local sname = vim.fn.input("Enter sname for test")
	REBAR_CT_CASE(vim.fn.expand("%:t:r"), vim.fn.expand("<cword>"), sname)
end

vim.keymap.set({ 'i', 'n', 't' }, '<A-t>o', ':lua REBAR_CT_CASE_TOGGLE()<CR>',{ silent = true })
vim.keymap.set({ 'i', 'n', 't' }, '<A-t>no', ':lua REBAR_CT_CASE_TOGGLE_INPUT()<CR>',{ silent = true })

