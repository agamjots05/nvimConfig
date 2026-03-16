return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    -- 1. Plugin Setup
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Keeps the default shortcut as a backup
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float", -- Opens as a floating window; change to 'horizontal' if preferred
      close_on_exit = true,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    })

    -- 2. Define your local keymap variable for consistency
    local keymap = vim.keymap

    -- 3. Leader Mappings (Normal and Terminal mode)
    keymap.set("n", "<leader>/", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    keymap.set("t", "<leader>/", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

    -- 4. Navigation Mappings (Inside the Terminal)
    -- These allow you to use Esc to exit and Ctrl+h/j/k/l to move between splits
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- Automatically apply these mappings when a terminal opens
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
