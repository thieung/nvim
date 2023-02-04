return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 3000 },
      sumneko_lua = {
        single_file_support = true,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              workspaceWord = true,
              callSnippet = "Both",
            },
            misc = {
              parameters = {
                "--log-level=trace",
              },
            },
            diagnostics = {
              groupSeverity = {
                strong = "Warning",
                strict = "Warning",
              },
              groupFileStatus = {
                ["ambiguity"] = "Opened",
                ["await"] = "Opened",
                ["codestyle"] = "None",
                ["duplicate"] = "Opened",
                ["global"] = "Opened",
                ["luadoc"] = "Opened",
                ["redefined"] = "Opened",
                ["strict"] = "Opened",
                ["strong"] = "Opened",
                ["type-check"] = "Opened",
                ["unbalanced"] = "Opened",
                ["unused"] = "Opened",
              },
              unusedLocalExclude = { "_*" },
            },
            format = {
              enable = false,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                continuation_indent_size = "2",
              },
            },
          },
        },
      },
    },
  },

  -- tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "luacheck",
      },
    },
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      {
        "jayp0521/mason-null-ls.nvim",
        opts = {
          ensure_installed = nil,
          automatic_installation = true,
          automatic_setup = false,
        },
      },
    },
    config = function()
      local nls = require("null-ls")
      local formatting = nls.builtins.formatting
      local diagnostics = nls.builtins.diagnostics

      nls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
          -- Formatting
          formatting.stylua,
          formatting.fish_indent,
          formatting.prettierd.with({
            filetypes = {
              "markdown",
              "liquid",
            },
          }),

          -- Diagnostic
          diagnostics.markdownlint,
          diagnostics.rubocop.with({
            command = "rubocop-daemon-wrapper",
          }),
        },
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
      })
    end,
  },

  -- highlight arguments
  {
    "m-demare/hlargs.nvim",
    event = "LspAttach",
    opts = {},
  },

  -- language specific extension modules
  { import = "plugins.extras.lang.ruby" },
  { import = "plugins.extras.lang.liquid" },
}
