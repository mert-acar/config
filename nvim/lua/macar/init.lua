require("macar.set")
require("macar.remap")
require("macar.lazy_init")

local augroup = vim.api.nvim_create_augroup
local MacarGroup = augroup("macar", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("LspAttach", {
	group = MacarGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<leader>vw", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>va", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vs", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vr", function()
			vim.lsp.buf.rename()
		end, opts)
	end,
})

autocmd("FileType", {
	group = MacarGroup,
	pattern = "netrw",
	callback = function()
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<leader>cp",
			':lua vim.fn.setreg("+", vim.fn.expand("%:p"))<CR>',
			{ noremap = true, silent = true }
		)
	end,
})
