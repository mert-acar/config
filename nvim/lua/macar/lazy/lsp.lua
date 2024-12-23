return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"jay-babu/mason-null-ls.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "pyright", "vimls" },
			automatic_installation = false,
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({ capabilities = capabilities })
				end,
				["harper_ls"] = function()
					-- attach glow to markdown server
					require("glow").setup()
					vim.keymap.set("n", "<leader>m", vim.cmd.Glow, { desc = "Markdown preview" })
					require("lspconfig").harper_ls.setup({
						filetypes = { "markdown" },
						capabilities = capabilities,
						settings = {
							["harper-ls"] = {
								linters = {
									sentence_capitalization = false,
								},
							},
						},
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = { diagnostics = { globals = { "vim" } } },
						},
					})
				end,
			},
		})

		-- Autocomplete
		local cmp = require("cmp")
		local kind_icons = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = " ",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = " ",
			Misc = " ",
		}

		require("mason-null-ls").setup({
			ensure_installed = { "yapf", "stylua", "black" },
			automatic_installation = true,
		})

		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local function set_python_formatter()
			-- Check if you are in the work project directory
			if vim.fn.getcwd():match("laconic") then
				-- Use black with line-length 100 for work project
				null_ls.setup({
					sources = {
						formatting.black.with({
							extra_args = { "--line-length", "100", "--fast" },
						}),
					},
				})
			else
				-- Default to yapf for other projects
				null_ls.setup({
					sources = {
						formatting.yapf,
					},
				})
			end
		end

		-- Function to format using the appropriate formatter
		function Format_with_dynamic_formatter()
			set_python_formatter()
			-- Call the LSP formatting command
			vim.lsp.buf.format({
				async = true,
				filter = function(client)
					-- Only use null-ls for formatting
					return client.name == "null-ls"
				end,
			})
		end

		-- Bind <leader>c to this dynamic formatting function
		vim.api.nvim_set_keymap(
			"n",
			"<leader>c",
			":lua Format_with_dynamic_formatter()<CR>",
			{ noremap = true, silent = true }
		)

		local luasnip = require("luasnip")
		local cmp_select = { behavior = cmp.SelectBehavior.Insert }
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},

			mapping = {
				["<S-TAB>"] = cmp.mapping.complete(),
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<TAB>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			window = {
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
			},
			experimental = {
				ghost_text = true,
				native_menu = false,
			},
		})

		vim.diagnostic.config({
			virtual_text = {
				severity = { vim.diagnostic.severity.WARN },
			},
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
