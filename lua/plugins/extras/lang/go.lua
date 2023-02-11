return {
  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "go",
    module = "gopher",
  },

  -- add go to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "go", "gomod", "gowork", "make" })
    end,
  },

  -- correctly setup mason lsp
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "gopls", "gofumpt", "goimports", "golines", "golangci-lint" })
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          linksInHover = false,
          staticcheck = true,
          gofumpt = true,
          analyses = { unusedparams = true, unreachable = true },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          codelenses = {
            generate = false,
            gc_details = false,
            test = false,
            tidy = true,
          },
        },
      },
      setup = {
        gopls = function(_, _opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "gopls" then
              vim.lsp.codelens.refresh()
              -- Set cursor on the line with err and execute
              vim.keymap.set("n", "<leader>;f", "GoIfErr", { buffer = buffer, desc = "Generate if err" })
              -- First set a cursor on public package/function/interface/struct and execute
              vim.keymap.set("n", "<leader>;c", "GoCmt", { buffer = buffer, desc = "Generate doc comment" })
              vim.keymap.set("n", "<leader>;g", "GoGenerate", { buffer = buffer, desc = "Go generate command" })
              vim.keymap.set(
                "n",
                "<leader>;o",
                "GoTestAdd",
                { buffer = buffer, desc = "Generate one test for spesific function/method" }
              )
              vim.keymap.set(
                "n",
                "<leader>;a",
                "GoTestAll",
                { buffer = buffer, desc = "Generate all tests for all functions/methods in current file" }
              )
              vim.keymap.set(
                "n",
                "<leader>;e",
                "GoTestExp",
                { buffer = buffer, desc = "Generate tests only for exported functions/methods in current file" }
              )
            end
          end)
        end,
      },
    },
  },
}
