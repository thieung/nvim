return {
  -- disable mini.bufremove
  { "echasnovski/mini.bufremove", enabled = false },

  -- use bdelete instead
  {
    "famiu/bufdelete.nvim",
    config = function()
      -- switches to Alpha dashboard when last buffer is closed
      local alpha_on_empty = vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "BDeletePost*",
        group = alpha_on_empty,
        callback = function(event)
          local fallback_name = vim.api.nvim_buf_get_name(event.buf)
          local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
          local fallback_on_empty = fallback_name == "" and fallback_ft == ""
          if fallback_on_empty then
            require("neo-tree").close_all()
            vim.cmd("Alpha")
            vim.cmd(event.buf .. "bwipeout")
          end
        end,
      })
    end,
    keys = {
      { "<leader>bd", "<cmd>Bdelete<CR>", desc = "Delete Buffer" },
      { "<leader>bD", "<cmd>Bdelete!<CR>", desc = "Delete Buffer (Force)" },
    },
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      enable_git_status = false,
      enable_diagnostics = false,
      close_if_last_window = true, -- close Neo-tree if it is the last window left in the tab
      filesystem = {
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      },
    },
  },

  -- customize telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "debugloop/telescope-undo.nvim" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
          n = {
            ["j"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["k"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["gg"] = function(...)
              return require("telescope.actions").move_to_top(...)
            end,
            ["G"] = function(...)
              return require("telescope.actions").move_to_bottom(...)
            end,
            ["<C-p>"] = function(...)
              return require("telescope.actions.layout").toggle_preview(...)
            end,
          },
        },
      },
      extensions = {
        project = {
          base_dirs = {
            "~/projects",
          },
        },
        undo = {
          use_delta = true,
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.4,
          },
        },
      },
    },
    keys = {
      {
        "<leader>fp",
        "<cmd>Telescope project display_type=full<CR>",
        desc = "Find project",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("project")
      telescope.load_extension("undo")
    end,
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_formatter_opts = {
        relative_time = true,
      },
      current_line_blame_opts = {
        delay = 100,
      },
    },
  },
}
