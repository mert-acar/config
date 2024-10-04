return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.5",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>f", function()
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = true,
			})
		end, { desc = "Find Files" })
		vim.keymap.set("n", "<C-f>", builtin.git_files, { desc = "Find in Git Files" })
		vim.keymap.set("n", "<C-s>", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "LiveGrep" })
	end,
}
