return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      ensure_installed = {"vimdoc", "python", "c", "lua", "rust", "bash", "markdown", "markdown_inline"},

      sync_install = false,
      auto_install = true,

      indent = {
        enable = true
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
    })

  end
}
