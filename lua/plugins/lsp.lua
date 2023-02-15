return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 3000 },
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
          formatting.pg_format,
          formatting.gofumpt,
          formatting.goimports,
          formatting.golines,

          -- Diagnostic
          diagnostics.markdownlint,
          diagnostics.rubocop.with({
            command = "rubocop-daemon-wrapper",
          }),
          diagnostics.golangci_lint,
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
  { import = "plugins.extras.lang.go" },
  { import = "plugins.extras.lang.liquid" },
}
