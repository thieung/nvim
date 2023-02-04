return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        theme_check = {
          root_dir = function(_)
            return vim.loop.cwd()
          end,
        },
      },
    },
  },
}
