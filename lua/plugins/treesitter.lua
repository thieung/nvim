return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag", -- Autoclose and autorename HTML and Vue tags
      "RRethy/nvim-treesitter-endwise", -- Automatically add end keywords for Ruby, Lua, Python, and more
    },
    opts = {
      ensure_installed = {
        "bash",
        "comment",
        "diff",
        "dockerfile",
        "dot",
        "fish",
        "git_rebase",
        "gitignore",
        "gitcommit",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "mermaid",
        "norg",
        "python",
        "sql",
        "toml",
        "vim",
        "yaml",
      },
      indent = { enable = false },
      endwise = { enable = true }, -- nvim-treesitter-endwise plugin
      autotag = { enable = true }, -- nvim-ts-autotag plugin
      context_commentstring = { enable = true }, -- nvim-ts-context-commentstring plugin
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
  },
}
