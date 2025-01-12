local disable_diag = [[
local function setup_diags()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
    })
end
setup_diags()
]]
return {
    "neovim/nvim-lspconfig",
    dependecies = {
        "willamboman/mason.nvim",
        "willamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel//mason-tool-installer.nvim",
        { "j-hui/fidge.nvim", ops = {} },
        { "folke/neodev.nvim", ops = {} },
    },
    opts = {
        servers = {
            gopls = {
                settings = {
                    gopls = {
                        gofumpt = false,
                        codelenses = {
                            gc_details = false,
                            generate = true,
                            regenerate_cgo = true,
                            run_govulncheck = true,
                            test = true,
                            tidy = true,
                            upgrade_dependency = true,
                            vendor = true,
                        },
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                        analyses = {
                            fieldalignment = true,
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
                        usePlaceholders = true,
                        completeUnimported = true,
                        staticcheck = true,
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                        semanticTokens = true,
                    },
                },
            },
        },
        setup = {
            gopls = function(_, opts)
                -- workaround for gopls not supporting semanticTokensProvider
                -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
                LazyVim.lsp.on_attach(function(client, _)
                    if not client.server_capabilities.semanticTokensProvider then
                        local semantic = client.config.capabilities.textDocument.semanticTokens
                        client.server_capabilities.semanticTokensProvider = {
                            full = true,
                            legend = {
                                tokenTypes = semantic.tokenTypes,
                                tokenModifiers = semantic.tokenModifiers,
                            },
                            range = true,
                        }
                    end
                end, "gopls")
                -- end workaround
            end,
        },
    },
}
