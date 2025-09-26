return {
  cmd = { "zls" },
  root_markers = { "build.zig" },
  filetypes = { "zig" },
  settings = {
    zls = {
      enable_inlay_hints = true,
      inlay_hints_show_builtin = true,
      include_at_in_builtins = true,
      warn_style = true,
    },
  },
}
