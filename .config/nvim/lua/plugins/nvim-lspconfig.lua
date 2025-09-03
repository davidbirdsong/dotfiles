return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", opts = {} },
        { "folke/neodev.nvim", opts = {} },
    },
    opts = function(_, opts)
        local lspconfig = require("lspconfig")
        local util = lspconfig.util

        local function project_name_to_container_name()
            local bufname = vim.api.nvim_buf_get_name(0)
            if not bufname or bufname == "" then
                return nil, nil
            end
            local filename = vim.fs.abspath(bufname) or bufname
            local project_dir = (util.root_pattern(".git")(filename)) or util.path.dirname(filename)
            local git_root = util.find_git_ancestor(project_dir) or project_dir
            local projname = vim.fn.fnamemodify(git_root, ":t")
            return project_dir, projname
        end

        local dirname, projname = project_name_to_container_name()

        local clang_cmd_bin = vim.fs.joinpath(dirname, "xdp-blocklist/scripts/clangd_lsp_bridge.py")
        local clang_cmd = { clang_cmd_bin, projname or "", dirname or "" }

        -- 1) Merge server settings
        opts.servers = opts.servers or {}
        opts.servers.clangd = vim.tbl_deep_extend("force", opts.servers.clangd or {}, {
            cmd = clang_cmd,
            on_init = function(client)
                vim.notify("Starting " .. client.name .. " with: " .. table.concat(client.config.cmd, " "))
            end,
            on_exit = function(_, code, signal)
                vim.notify(
                    ("clangd exited (code=%s signal=%s)"):format(tostring(code), tostring(signal)),
                    vim.log.levels.WARN
                )
            end,
            root_dir = util.root_pattern(".git"),
            -- any other clangd opts…
        })

        -- 2) (Optional) per-server setup hook (runs before default)
        opts.setup = opts.setup or {}
        opts.setup.clangd = function(_, server_opts)
            -- sanity: ensure the cmd looks right
            vim.notify("Starting clangd with: " .. table.concat(server_opts.cmd or {}, " "))
            -- return false → let LazyVim perform the default setup with these opts
            return false
        end

        -- Example: keep your gopls settings merged
        opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, {
            settings = {
                gopls = {
                    gofumpt = false,
                    codelenses = {
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
        })
    end,
}
