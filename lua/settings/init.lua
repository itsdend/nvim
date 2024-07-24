local set = vim.opt

set.scrolloff = 8
set.relativenumber = true
set.number = true
set.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
set.laststatus = 3
set.linebreak = true

-- window navigation
vim.keymap.set('n', '<A-h>', '<C-W>h', { silent = true })
vim.keymap.set('n', '<A-j>', '<C-W>j', { silent = true })
vim.keymap.set('n', '<A-k>', '<C-W>k', { silent = true })
vim.keymap.set('n', '<A-l>', '<C-W>l', { silent = true })


-- split to the left and down
vim.keymap.set('n', '<A-w>l', '<C-W>v', { silent = true })
vim.keymap.set('n', '<A-w>j', '<C-W>s', { silent = true })
vim.keymap.set('n', '<A-w><A-l>', '<C-W>v', { silent = true })
vim.keymap.set('n', '<A-w><A-j>', '<C-W>s', { silent = true })


-- resize
vim.keymap.set('n', '<A-b>l', ':vertical resize +16<CR>', { silent = true })
vim.keymap.set('n', '<A-b><A-l>', ':vertical resize +16<CR>', { silent = true })

vim.keymap.set('n', '<A-b>h', ':vertical resize -16<CR>', { silent = true })
vim.keymap.set('n', '<A-b><A-h>', ':vertical resize -16<CR>', { silent = true })

vim.keymap.set('n', '<A-b>j', ':resize +9<CR>', { silent = true })
vim.keymap.set('n', '<A-b><A-j>', ':resize +9<CR>', { silent = true })

vim.keymap.set('n', '<A-b>k', ':resize -9<CR>', { silent = true })
vim.keymap.set('n', '<A-b><A-k>', ':resize -9<CR>', { silent = true })

vim.keymap.set('n', '<leader>v', '<C-v>')


--closing windows and buffers

vim.keymap.set({ 'n', 'i' }, '<A-i>w', ':q<CR>', { silent = true })
vim.keymap.set({ 'n', 'i' }, '<A-i><A-w>', ':q<CR>', { silent = true })

vim.keymap.set({ 'n', 'i' }, '<A-i>o', '<C-w>o', { silent = true })
vim.keymap.set({ 'n', 'i' }, '<A-i><A-o>', '<C-w>o', { silent = true })

-- Define a function to close the current buffer
function CLOSE_CURRENT_BUFFER()
	vim.cmd("bdelete")
end
-- Set up keymap for Alt + u q to call the function
vim.keymap.set("n", "<A-i>i", "<cmd>lua CLOSE_CURRENT_BUFFER()<CR>", { silent = true })
vim.keymap.set("n", "<A-i><A-i>", "<cmd>lua CLOSE_CURRENT_BUFFER()<CR>", { silent = true })



-- Define a function to open the specified file, basically TODO list
-- TODO
function OPEN_WORK_TASKS()
	vim.cmd("edit /mnt/f/repo/notes/work_tasks.md")
end
vim.keymap.set("n", "<A-u>w", "<cmd>lua OPEN_WORK_TASKS()<CR>", { silent = true })




vim.keymap.set("n", "<S-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })


-- OPEN IN BROWSER
function OPEN_IN_BROWSER(file_loc)
	vim.fn.system("vivaldi " .. file_loc)
end

vim.keymap.set("n", "<A-q>.", '<cmd>lua OPEN_IN_BROWSER(vim.fn.expand("%:p"))<CR>', { silent = true })
vim.keymap.set("n", "<A-q>t",
	'<cmd>lua OPEN_IN_BROWSER(vim.fn.expand("%:h") .. "/" .. "_build/test/logs/suite.log.latest.html")<CR>',
	{ silent = true })


-- Project _thoughts

local function check_file_existence()
	return vim.fn.filereadable('./_thoughts/proj_things.md') == 1
end

function PROJ_THINGS()
	local file_path = "./_thoughts/proj_things.md"
	if check_file_existence() then
		vim.cmd("edit " .. file_path)
	else
		vim.cmd("!mkdir " .. "./_thoughts/")
		vim.cmd("!touch " .. "proj_things.md")
		vim.cmd("edit" .. file_path)
	end
end

vim.keymap.set("n", "<A-u>.", "<cmd>lua PROJ_THINGS()<CR>", { silent = true })

-- jumps on editor diagnostics and stuff

vim.keymap.set("n", '<A-n>d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })
vim.keymap.set("n", '<A-m>d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })

vim.keymap.set("n", '<A-n>e', '<cmd>lua vim.diagnostic.goto_next( {severity = vim.diagnostic.severity.ERROR})<CR>',
	{ silent = true })
vim.keymap.set("n", '<A-m>e', '<cmd>lua vim.diagnostic.goto_prev( {severity = vim.diagnostic.severity.ERROR})<CR>',
	{ silent = true })

vim.keymap.set("n", '<A-n>w', '<cmd> lua vim.diagnostic.goto_next( {severity = vim.diagnostic.severity.WARN})<CR>',
	{ silent = true })
vim.keymap.set("n", '<A-m>w', '<cmd> lua vim.diagnostic.goto_prev( {severity = vim.diagnostic.severity.WARN})<CR>',
	{ silent = true })

vim.keymap.set('n', '<A-n>c', '<cmd> Gitsigns next_hunk<CR>', { silent = true })
vim.keymap.set('n', '<A-m>c', '<cmd> Gitsigns prev_hunk<CR>', { silent = true })
--
--#region DEPRECATED
--
--otvori file u operi, teski hardcode, necu brisati ndms
-- vrijedi za winodws masine i wsl2
function OPEN_IN_OPERA_GX(current_file)
	local opera_invoke =
	"cmd.exe /C start \"\" \"$(wslpath -w /mnt/c/Users/Marko/AppData/Local/Programs/Opera\\ GX/launcher.exe)\" $(wslpath -w " ..
	current_file .. ")"
	vim.fn.system(opera_invoke)
end

vim.keymap.set('n', '<A-u>b', ':lua OPEN_IN_OPERA_GX(vim.fn.expand("%:p"))<CR>', { silent = true })
vim.keymap.set('n', '<A-u><A-b>', ':lua OPEN_IN_OPERA_GX(vim.fn.expand("%:p"))<CR>', { silent = true })
--#endregion
