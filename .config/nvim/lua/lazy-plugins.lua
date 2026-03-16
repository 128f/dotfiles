return {
  -- Git
  {
    "airblade/vim-gitgutter",
    event = "BufReadPost"
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" }
  },

  -- Color themes/syntax highlighting
  {
    "nanotech/jellybeans.vim",
    priority = 1000
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
        },
      })
    end
  },
  {
    "RRethy/nvim-base16",
    lazy = true
  },

  -- Language-specific plugins
  {
    "rust-lang/rust.vim",
    ft = "rust"
  },
  {
    "LnL7/vim-nix",
    ft = "nix"
  },
  {
    "elkowar/yuck.vim",
    ft = "yuck"
  },

  -- LSP plugins
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },

  -- Completion framework
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      require('snippets')
    end
  },
  {
    "hrsh7th/cmp-buffer",
    event = "InsertEnter"
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter"
  },
  {
    "hrsh7th/cmp-path",
    event = "InsertEnter"
  },
  {
    "hrsh7th/cmp-vsnip",
    event = "InsertEnter"
  },
  {
    "hrsh7th/vim-vsnip",
    event = "InsertEnter"
  },

  -- Diagnostics
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy"
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup({})
    end
  },

  -- UI
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "Files", "Buffers", "Rg", "Lines" }
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('tree')
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Utilities
  {
    "tpope/vim-commentary",
    keys = { "gc", "gcc" }
  },
  {
    "junegunn/vim-easy-align",
    keys = { { "ga", mode = { "n", "x" } } }
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "nix",
          "terraform",
          "python",
          "rust",
          "c",
          "go",
          "typescript",
          "javascript",
          "yuck"
        },
        highlight = {
          enable = true,
        }
      }
    end
  },
}
