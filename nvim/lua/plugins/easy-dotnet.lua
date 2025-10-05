return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", },
  ft = { "cs", "csproj", "sln", "slnx", "props", "csx", "targets" },
  opts = {
    terminal = function(path, action, args)
      args = args or ""
      local commands = {
        run = function() return string.format("dotnet run --project %s %s", path, args) end,
        test = function() return string.format("dotnet test %s %s", path, args) end,
        restore = function() return string.format("dotnet restore %s %s", path, args) end,
        build = function() return string.format("dotnet build %s %s", path, args) end,
        watch = function() return string.format("dotnet watch --project %s %s", path, args) end,
      }
      local command = commands[action]()
      if require("easy-dotnet.extensions").isWindows() == true then command = command .. "\r" end
      vim.cmd("split")
      vim.cmd("term " .. command)
    end,
    debugger = {
      bin_path = "netcoredbg",
      mappings = {
        open_variable_viewer = { lhs = "<leader>dv", desc = "open variable viewer" },
      },
    },
  },
  config = function(_, opts)
    require("easy-dotnet").setup(opts)
    if require("dap") then
      require("easy-dotnet.netcoredbg").register_dap_variables_viewer()
    end
  end,
}
