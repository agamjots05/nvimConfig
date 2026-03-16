return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Treesitter handles tags correctly but returns 0 for empty parens.
    -- cindent handles parens correctly but mangles HTML/JSX tags.
    -- This indentexpr tries treesitter first, falls back to cindent.
    _G._indent_fallback = function()
      local ts = require("nvim-treesitter").indentexpr()
      if ts >= 0 then return ts end
      return vim.fn.cindent(vim.v.lnum)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
      callback = function()
        vim.opt_local.indentexpr = "v:lua._indent_fallback()"
        vim.opt_local.smartindent = false
      end,
    })
  end,
}
