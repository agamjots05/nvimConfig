return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPost", -- Use this instead of 'LazyFile'
  opts = {},
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev Todo" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo List" },
  },
}
