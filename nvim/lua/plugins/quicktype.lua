return {
  "midoBB/nvim-quicktype" ,
  cmd = "QuickType",
  ft = { "rust", "cs" },
  opts = {
    filetypes = {
      cs = {
        lang = "cs",
        additional_options = {
          ["framework"] = "SystemTextJson",
          ["density"] = "normal",
          ["csharp-version"] = "6",
          ["features"] = "attributes-only"
        },
      },
    },
  },
}
