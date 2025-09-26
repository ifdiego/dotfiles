return {
  cmd = { "rust-analyzer" },
  root_markers = { "Cargo.toml" },
  filetypes = { "rust" },
  settings = {
    ["rust_analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        features = "all",
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
