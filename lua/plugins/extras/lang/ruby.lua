return {
  -- add ruby to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ruby" })
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {
          -- disable mason install solargraph since ASDF already do it
          mason = false,
          -- default config: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
          settings = {
            solargraph = {
              diagnostics = false,
            },
          },
        },
      },
    },
  },
}
