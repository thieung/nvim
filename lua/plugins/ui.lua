return {
  -- disable noice.nvim
  {
    "folke/noice.nvim",
    enabled = false,
  },

  -- floating winbar
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      -- local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = {
              default = true,
              group = "StatusLine",
            },
            InclineNormalNC = {
              default = true,
              group = "StatusLineNC",
            },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "petertriho/nvim-scrollbar", --scrollbar
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require("tokyonight.colors").setup()
      scrollbar.setup({
        handle = { color = colors.bg_highlight },
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
    end,
  },

  {
    "folke/styler.nvim", -- style windows with different colorschemes
    event = "VeryLazy",
    opts = {
      themes = {
        markdown = { colorscheme = "tokyonight-storm" },
        help = { colorscheme = "oxocarbon", background = "dark" },
      },
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      -- https://github.com/yamatsum/nvim-nonicons/blob/main/lua/nvim-web-devicons/override.lua
      local palette = {
        orange = "#d18616",
        black = "#586069",
        bright_black = "#959da5",
        white = "#d1d5da",
        bright_white = "#fafbfc",
        red = "#ea4a5a",
        bright_red = "#f97583",
        green = "#34d058",
        bright_green = "#85e89d",
        yellow = "#ffea7f",
        bright_yellow = "#ffea7f",
        blue = "#2188ff",
        bright_blue = "#79b8ff",
        magenta = "#b392f0",
        bright_magenta = "#b392f0",
        cyan = "#39c5cf",
        bright_cyan = "#56d4dd",
      }
      -- https://github.com/yamatsum/nvim-nonicons/blob/main/lua/nvim-nonicons/mapping.lua
      local mapping = {
        ["ruby"] = "61880",
        ["go"] = "61789",
      }
      local function get(name)
        return vim.fn.nr2char(mapping[name])
      end

      return {
        override = {
          ["rake"] = {
            icon = get("ruby"),
            color = palette.bright_red,
            name = "Rake",
          },
          ["rakefile"] = {
            icon = get("ruby"),
            color = palette.bright_red,
            name = "Rakefile",
          },
          ["rb"] = {
            icon = get("ruby"),
            color = palette.bright_red,
            name = "Rb",
          },
          ["go"] = {
            icon = get("go"),
            color = palette.bright_blue,
            name = "Go",
          },
        },
      }
    end,
  },
}
