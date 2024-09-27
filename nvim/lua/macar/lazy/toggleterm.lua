function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
end

return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local toggleterm = require("toggleterm")
			toggleterm.setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
			vim.keymap.set("n", "<leader>t", function()
				vim.cmd.ToggleTerm("direction=float")
			end, { desc = "Toggle floating terminal" })
			vim.keymap.set("n", "<leader>tp", function()
				require("toggleterm.terminal").Terminal:new({ cmd = "python3", hidden = true }):toggle()
			end, { desc = "Toggle floating python term" })
		end,
	},
}
