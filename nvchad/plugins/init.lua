return {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig"
    }
  },
  user = {
    ["goolord/alpha-nvim"] = {
      disable = false,
    },
    ["tpope/vim-unimpaired"] = {},
    ["tpope/vim-repeat"] = {},
    ["tpope/vim-surround"] = {},
    ["karb94/neoscroll.nvim"] = {
      config = function()
        require("neoscroll").setup()
      end,

      -- lazy loading
      setup = function()
        nvchad.packer_lazy_load "neoscroll.nvim"
      end,
    },
    ["luukvbaal/stabilize.nvim"] = {
      config = function()
        require("stabilize").setup()
      end
    },
  },
}
