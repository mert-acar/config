return {
  {
    "tpope/vim-fugitive",
    config = function() 
      vim.keymap.set("n", "<leader>,", vim.cmd.Git, {desc = "Git Engine"})
    end
  }
}
