require("neo-tree").setup({
	close_if_last_window = false,

	window = {
		position = "right",
	},

	default_component_configs = {
		name = {
			use_git_status_colors = true,
		},
	},

	event_handlers = {
		{
			event = "file_opened",
			handler = function()
				require("neo-tree").close_all()
			end,
		},
	},
})


vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		if vim.bo.filetype == "neo-tree" then
			vim.schedule(function()
				vim.cmd("Neotree close")
			end)
		end
	end,
})

-- Neo-tree keymaps
vim.keymap.set(
	"n",
	"<A-u>e",
	"<cmd>Neotree filesystem reveal right toggle<CR>",
	{ noremap = true, silent = true }
)

vim.keymap.set(
	"n",
	"<A-u><A-e>",
	"<cmd>Neotree filesystem reveal right toggle<CR>",
	{ noremap = true, silent = true }
)


-- Define highlight groups for specific characters
vim.api.nvim_set_hl(0, "AsciiArtBlue", {
	fg = "#7ac3ff",
	bold = true,
})

vim.api.nvim_set_hl(0, "AsciiArtForeground", {
	fg = "#eb87b6",
	bold = true,
})

vim.api.nvim_set_hl(0, "AsciiArtGreen", {
	fg = "#4fc8b7",
	bold = true,
})

vim.api.nvim_set_hl(0, "AsciiArtPink", {
	fg = "#fc50b4",
	bold = true,
})


local ascii_art = [[
                 #@@-                                 @@@@
                @@@G@@@:                           *@@GG@@%
               .@@GGGGG@@@..                  *:-@@@GGGGG@@.
               .@@G#####GG@@@@:             #@@@@@GG###GG@@.
               .@@G%####GGGG@@@@@@@@@@@@@@@%@@@GGG@@###%G@@.
               .@@GG####GGGGGG@@GGGGG@@GGGGG@@GGGG@####GG@#-
               .%@GGG###GG@@@GGGGGGGGGGGGGGGG@@GG@@@###GG@%-
               	@@@GGGGGGG@@@@@@@GGGGGGGGGGG@@@@@@@####GG@@-
                %@@G@@@@@@@@@@@@@@@@@GG@@@@@@@@@@@@@@@%#G@@.
                -@@@@@@@@@@@=* ...@@GGGG@@*.. =#%@@@@@@GG@-
               :*%@@@@@@@@@- |X   @GGGGGG@+  X| .*@@@@@@G@@*.
               	#@@@@@@@@@@-     @GGGGGGGG@%     =*@@@@@@@@@:
               *@@@@@@@@#######GGGGGGGGGGGGGGG########@@@@@@@:
             -:+@@@@@########&G#/           \&GG#############@#
              %@@@@@########G#/  XXXX  XXXX  /&&G############@+
            .#@@@@@########G####\ `'    `'  /####G###########+-
            =#%@@%#########G######\       _/#####G##########@#+
              .@@# .:%################ #################@=.
                .GG     :###########/   \#############=
               	-%GGG    .#######/         \#######-.
               	  +@GG:          _<#######>_
                  .%@@@@%.          ~###~
                    +@@@@@#*%#:
                    :%@@@@@@@@#####%++.
               	     .=#@@@@@@@#######*.
                       	 =@@@@@@@@######-
                       	       ..::####-
...........................................................................
::::::::####:'##::: ##:'##::::'##::::::::::'##::::'##:'####:'##::::'##:::::
:::::::: ##:: ###:: ##: ##:::: ##:::::::::: ##:::: ##:. ##:: ###::'###:::::
:::::::: ##:: ####: ##: ##:::: ##:::::::::: ##:::: ##:: ##:: ####'####:::::
:::::::: ##:: ## ## ##: ##:::: ##::######:: ##:::: ##:: ##:: ## ### ##:::::
:::::::: ##:: ##. ####: ##:::: ##::......::. ##:: ##::: ##:: ##. #: ##:::::
:::::::: ##:: ##:. ###: ##:::: ##:::::::::::. ## ##:::: ##:: ##:.:: ##:::::
::::::::####: ##::. ##:. #######:::::::::::::. ###::::'####: ##:::: ##:::::
:::::::....::..::::..:::.......:::::::::::::::...:::::....::..:::::..::::::
]]


vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local argc = vim.fn.argc()

		-- If a file was passed as an argument, skip the dashboard
		if argc > 0 then
			local target = vim.fn.argv(0)

			if vim.fn.isdirectory(target) == 0 then
				return
			end
		end

		-- Check if the only buffer is the default [No Name] buffer
		local buffers = vim.api.nvim_list_bufs()

		if #buffers == 1 and vim.api.nvim_buf_get_name(buffers[1]) == "" then
			vim.cmd("bd 1")
		end

		-- Open the ASCII art buffer
		vim.cmd("enew")

		local buf = vim.api.nvim_get_current_buf()
        vim.wo.number = false
        vim.wo.relativenumber = false

		-- Make it a scratch buffer
		vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
		vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
		vim.api.nvim_buf_set_option(buf, "swapfile", false)

		-- Add ASCII art
		local art_lines = vim.split(ascii_art, "\n")

		vim.api.nvim_buf_set_lines(
			buf,
			0,
			-1,
			false,
			art_lines
		)

		-- Apply colors character by character
		for line_num, line in ipairs(art_lines) do
			for col_num = 1, #line do
				local char = line:sub(col_num, col_num)

				if char == "@"
					or char == "."
					or char == "="
					or char == "*"
					or char == "+"
					or char == ":"
					or char == "-"
					or char == "%" then

					vim.api.nvim_buf_add_highlight(
						buf,
						-1,
						"AsciiArtBlue",
						line_num - 1,
						col_num - 1,
						col_num
					)

				elseif char == "G" then

					vim.api.nvim_buf_add_highlight(
						buf,
						-1,
						"AsciiArtForeground",
						line_num - 1,
						col_num - 1,
						col_num
					)

				elseif char == "X"
					or char == "`"
					or char == "|"
					or char == "'" then

					vim.api.nvim_buf_add_highlight(
						buf,
						-1,
						"AsciiArtGreen",
						line_num - 1,
						col_num - 1,
						col_num
					)

				elseif char == "#"
					or char == "_"
					or char == "~"
					or char == "<"
					or char == ">"
					or char == "\\"
					or char == "/" then

					vim.api.nvim_buf_add_highlight(
						buf,
						-1,
						"AsciiArtPink",
						line_num - 1,
						col_num - 1,
						col_num
					)
				end
			end
		end

		-- Open Neo-tree
		vim.cmd("Neotree filesystem reveal right")
	end,
})


-- Line numbers
-- Neo-tree and dashboard: OFF
-- Normal files: ON
vim.api.nvim_create_autocmd("FileType", {
	pattern = "neo-tree",
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})


vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local ft = vim.bo.filetype

		if ft == "neo-tree" or vim.bo.buftype == "nofile" then
			vim.wo.number = false
			vim.wo.relativenumber = false
		else
			vim.wo.number = true
			vim.wo.relativenumber = true
		end
	end,
})
