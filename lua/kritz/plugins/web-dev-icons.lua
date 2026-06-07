return {
  'nvim-web-devicons',
  -- This ensures the Lean icon matches the VS Code look
  override = {
    lean = {
      icon = "∀",
      color = "#519aba", -- This is the standard blue used in vscode-icons
      cterm_color = "74",
      name = "Lean"
    }
  },
  -- This is required for the icons to show up in other plugins
  default = true,
}
