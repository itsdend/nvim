require('neo-tree').setup({
	default_component_configs = {
		close_if_last_window = false,
		window = {
			position = "right"
		},
		name = {
			use_git_status_colors = true
		}
	},
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				require("neo-tree").close_all()
			end
		},
		{
			event = "VimEnter",
			handler = function(file_path)
				require("neo-tree.command").execute({ action = "close" })
			end
		}
	}
})
vim.keymap.set("n", "<A-u>e", ":Neotree filesystem reveal right toggle<CR>",
	{ noremap = true, silent = true })
vim.keymap.set("n", "<A-u><A-e>", ":Neotree filesystem reveal right toggle<CR>",
	{ noremap = true, silent = true })

-- Define highlight groups for specific characters
vim.api.nvim_set_hl(0, "AsciiArtBlue", { fg = "#7ac3ff", bold = true })
vim.api.nvim_set_hl(0, "AsciiArtForeground", { fg = "#eb87b6", bold = true })
vim.api.nvim_set_hl(0, "AsciiArtGreen", { fg = "#4fc8b7", bold = true })
vim.api.nvim_set_hl(0, "AsciiArtPink", { fg = "#fc50b4", bold = true })


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
		-- Check if the only buffer is the default [No Name] buffer and close it
		local buffers = vim.api.nvim_list_bufs()
		if #buffers == 1 and vim.api.nvim_buf_get_name(buffers[1]) == "" then
			-- Close the [No Name] buffer to avoid having an extra window
			vim.cmd("bd 1")
		end

		-- Open the ASCII art buffer as the first and only buffer
		vim.cmd("enew")                        -- create a new empty buffer (replacing [No Name])
		local buf = vim.api.nvim_get_current_buf() -- get current buffer id
		-- Set the buffer as a scratch buffer
		vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
		vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
		vim.api.nvim_buf_set_option(buf, "swapfile", false)
		-- Add the ASCII art content to the buffer
		-- vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(ascii_art, "\n"))
		--   -- Add the ASCII art content to the buffer
		local art_lines = vim.split(ascii_art, "\n")
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, art_lines)

		-- Apply color to each line, character by character
		for line_num, line in ipairs(art_lines) do
			for col_num = 1, #line do
				local char = line:sub(col_num, col_num)

				-- Apply different highlights based on character
				if char == "@" or char == "." or char == "=" or char == "*" or char == "+" or char == ":" or char == "-" or char == "%" then
					vim.api.nvim_buf_add_highlight(buf, -1, "AsciiArtBlue", line_num - 1, col_num - 1, col_num)
				elseif char == "G" then
					vim.api.nvim_buf_add_highlight(buf, -1, "AsciiArtForeground", line_num - 1, col_num - 1, col_num)
				elseif char == "X" or char == "`" or char == "|" or char == "'" then
					vim.api.nvim_buf_add_highlight(buf, -1, "AsciiArtGreen", line_num - 1, col_num - 1, col_num)
				elseif char == "#" or char == "_" or char == "~" or char == "<" or char == ">" or char == "\\" or char == "/" then
					vim.api.nvim_buf_add_highlight(buf, -1, "AsciiArtPink", line_num - 1, col_num - 1, col_num)
				end
			end
		end

		vim.cmd(":Neotree right")
	end,
})
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.api.nvim_buf_get_name(0) == "[No Name]" or vim.api.nvim_buf_get_name(0) == "neo-tree filesystem [1]" or vim.api.nvim_buf_get_name(0) == "" then
		vim.api.nvim_win_set_option(0, "number", false)     -- no line numbers
		vim.api.nvim_win_set_option(0, "relativenumber", false) -- no relative numbers
		else
		vim.api.nvim_win_set_option(0, "number", true)     -- no line numbers
		vim.api.nvim_win_set_option(0, "relativenumber", true) -- no relative numbers
		end
	end,
})


  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
	  vim.cmd("Neotree close")
    end,
  })

