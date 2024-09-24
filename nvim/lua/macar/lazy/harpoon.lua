return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function ()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {desc = "Add file to harpoon"})
      vim.keymap.set("n", "<C-q>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Toggle harpoon list"})

      vim.keymap.set("n", "<C-g>", function() harpoon:list():select(1) end, {desc = "Jump to harpooned file 1"})
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, {desc = "Jump to harpooned file 2"})
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, {desc = "Jump to harpooned file 3"})
    end
  }
}
