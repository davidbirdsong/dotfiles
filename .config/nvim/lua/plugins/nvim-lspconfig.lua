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

local lspconfig = require("lspconfig")
-- Notably _not_ including `compile_commands.json`, as we want the entire project
local root_pattern = lspconfig.util.root_pattern(".git")

-- Might be cleaner to try to expose this as a pattern from `lspconfig.util`, as
-- really it is just stolen from part of the `clangd` config
local function project_name_to_container_name()
    -- Turn the name of the current file into the name of an expected container, assuming that
    -- the container running/building this file is named the same as the basename of the project
    -- that the file is in
    --
    -- The name of the current buffer
    local bufname = vim.api.nvim_buf_get_name(0)

    local filename = vim.fs.abspath(bufname)

    -- Then the directory of the project
    local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)

    -- And finally perform what is essentially a `basename` on this directory
    return project_dirname, vim.fn.fnamemodify(lspconfig.util.find_git_ancestor(project_dirname), ":t")
end

local dirname, projname = project_name_to_container_name()
local clang_cmd = { "ensure_exec.sh", projname, dirname }

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
        clangd = function(_, opts)
            opts.cmd = clang_cmd
        end,
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
}
