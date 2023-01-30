return {
  "mfussenegger/nvim-dap",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text", -- help to find variable definitions in debug mode
      config = true,
    },
    {
      "rcarriga/nvim-dap-ui", -- nice UI for nvim-dap
      config = {
        icons = Icons.misc,
        controls = {
          icons = Icons.dap,
        },
      },
    },
  },
  config = function()
    local dap_icons = Icons.dap
    vim.fn.sign_define("DapBreakpoint", { text = dap_icons.breakpoint, texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = dap_icons.breakpoint_condition, texthl = "", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = dap_icons.breakpoint_rejected, texthl = "", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapLogPoint", { text = dap_icons.log_point, texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = dap_icons.stopped, texthl = "", linehl = "", numhl = "" })

    local dap = require("dap")
    local dapui = require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end

    require("which-key").register({
      ["<leader>d"] = { name = "+debug" },
    })

    require("dap").defaults.fallback.terminal_win_cmd = "enew"
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      callback = function()
        require("dap.ext.autocompl").attach()
      end,
    })
  end,
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<leader>dw",
      function()
        require("dap.ui.widgets").hover()
      end,
      desc = "Widgets Hover",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.open()
      end,
      desc = "Repl",
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle({})
      end,
      desc = "Dap UI",
    },
  },
}
