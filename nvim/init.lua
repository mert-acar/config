require("macar")

local augroup = vim.api.nvim_create_augroup
local MacarGroup = augroup('macar', {})
local autocmd = vim.api.nvim_create_autocmd
autocmd('LspAttach', {
  group = MacarGroup,
  callback = function(e)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {buffer = e.buf, desc = "Go to definition"})
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {buffer = e.buf, desc = "Show help"})
    vim.keymap.set("n", "<leader>lq", function() vim.diagnostic.open_float() end, {buffer = e.buf, desc = "Diagnostics"})
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, {buffer = e.buf, desc = "Code action"})
    vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, {buffer = e.buf, desc = "Refactor"})
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {buffer = e.buf, desc = "Signature Help"})
    vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.goto_next() end, {buffer = e.buf, desc = "Go to next diagnostic"})
    vim.keymap.set("n", "<leader>lj", function() vim.diagnostic.goto_prev() end, {buffer = e.buf, desc = "Go to prev diagnostic"})
  end
})
