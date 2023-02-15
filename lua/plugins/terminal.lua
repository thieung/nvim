return {
  "akinsho/toggleterm.nvim",
  keys = {
    { [[<C-\>]] },
  },
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = "0",
      start_in_insert = true,
      persist_size = true,
      direction = "float",
      highlights = {
        FloatBorder = { link = "FloatBorder" },
        NormalFloat = { link = "NormalFloat" },
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      hidden = true,
      direction = "float",
    })

    vim.keymap.set("n", "<leader>gg", function()
      lazygit:toggle()
    end, { desc = "toggleterm: toggle lazygit" })
  end,
}
