local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "typescript-language-server",
        "zls"
      }
    }
  },
  {
    "github/copilot.vim",
    lazy = false
  }
}
return plugins
