return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "html",
                "cssls",
                "jsonls",
                "bashls",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(ev)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
                end

                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")
                map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
                map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
            end,
        })

        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                    [vim.diagnostic.severity.HINT] = "󰌵 ",
                },
            },
            underline = true,
            update_in_insert = false,
            float = { border = "rounded" },
        })
    end,
}
