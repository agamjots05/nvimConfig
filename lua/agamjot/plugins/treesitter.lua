return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    -- Configure parser installation
    require('nvim-treesitter.config').setup({
      ensure_installed = {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'markdown',
        'go',
        'typescript',
        'javascript',
        'python',
        'html',
        'css',
      },
      auto_install = true,
    })
    
    -- Enable highlighting manually
    vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
      pattern = '*',
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.bo[buf].filetype
        
        -- Skip special filetypes
        local skip_fts = {
          'NvimTree',
          'alpha',
          'dashboard',
          'lazy',
          'help',
          'man',
          'qf',
          'toggleterm',
          '',
        }
        
        for _, skip_ft in ipairs(skip_fts) do
          if ft == skip_ft then
            return
          end
        end
        
        -- Start treesitter if not already active
        if not vim.treesitter.highlighter.active[buf] then
          pcall(vim.treesitter.start, buf)
        end
      end,
    })
  end,
}
