return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {"nvimtools/none-ls.nvim",},
  config = function ()
    require("mason-null-ls").setup({
      ensure_installed = { "yapf", "stylua", "black" },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local function set_python_formatter()
      if vim.fn.getcwd():match("laconic") then
        null_ls.setup({
          sources = {
            formatting.black.with({
              extra_args = { "--line-length", "100", "--fast" },
            }),
          },
        })
      else
        null_ls.setup({
          sources = {
            formatting.yapf,
          },
        })
      end
    end

    local function attach_null_ls_to_buffer()
      local clients = vim.lsp.get_active_clients()
      if #clients > 0 then
        for _, client in ipairs(clients) do
          if client.name == "null-ls" then
            vim.lsp.buf_attach_client(0, client.id)
            return
          end
        end
      end
    end

    -- Auto-attach null-ls to Python files
    vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
      pattern = {"*.py"},
      callback = function()
        set_python_formatter()
        -- Safely attach null-ls to the buffer
        attach_null_ls_to_buffer()
      end
    })

  end
}
