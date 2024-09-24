return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = { "yapf", "stylua" },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.yapf.with({
          extra_args = {
            "--style", "{based_on_style: facebook, column_limit: 100, indent_width: 2, continuation_indent_width = 2}"
          }
        }),
        null_ls.builtins.formatting.stylua,
      },
    })
  end
}
