return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>tT",
      "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>ts",
      "<cmd>Trouble symbols toggle focus=true<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>tq",
      "<cmd>Trouble qflist toggle focus=true<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
