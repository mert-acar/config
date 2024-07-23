local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install plugins here
return packer.startup(
  function(use)
    use { "wbthomason/packer.nvim"}
    use { "nvim-lua/plenary.nvim"}
    use { "christoomey/vim-tmux-navigator"}

    use { "folke/which-key.nvim"}

    use { "akinsho/bufferline.nvim"}
    use { "moll/vim-bbye" }

    -- CMP Plugins (completion)
    use { "hrsh7th/nvim-cmp"}
    use { "hrsh7th/cmp-buffer"}
    use { "hrsh7th/cmp-path"}
    use { "hrsh7th/cmp-cmdline"}
    use { "hrsh7th/cmp-nvim-lsp"}

    -- LSP
    use { "neovim/nvim-lspconfig"}
    use { "williamboman/mason.nvim"}
    use { "williamboman/mason-lspconfig.nvim"}
    use { "jose-elias-alvarez/null-ls.nvim"}

    use { "nvim-treesitter/nvim-treesitter"}
    use { "JoosepAlviste/nvim-ts-context-commentstring"}
    use { "numToStr/Comment.nvim"}

    use { "kyazdani42/nvim-web-devicons"}
    use { "kyazdani42/nvim-tree.lua", commit = "7282f7de8aedf861fe0162a559fc2b214383c51c" }

    use { "stevearc/conform.nvim"}

    use { "lewis6991/impatient.nvim"}

    use { "crusoexia/vim-monokai"}

    use { "nvim-telescope/telescope.nvim"}
    use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end,}

    -- Automatically set up configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end
)
