return {
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = true,
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
}
