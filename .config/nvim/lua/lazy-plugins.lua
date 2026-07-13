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

  -- Rust: inlay type hints, hover actions, clippy diagnostics.
  -- Owns rust_analyzer (do NOT also enable it in lsp.lua).
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = "rust",
    init = function()
      local common = require('lsp_common')
      vim.g.rustaceanvim = {
        server = {
          on_attach = common.on_attach,
          capabilities = common.capabilities,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = true,
              check = { command = "clippy" },
              inlayHints = {
                bindingModeHints = { enable = false },
                closureReturnTypeHints = { enable = "with_block" },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
            },
          },
        },
      }
    end,
  },

  -- On-demand AI completion (qwen-coder via Ollama on the LAN). Not an
  -- automatic cmp source; invoked manually with <C-g> (see completion.lua).
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "InsertEnter",
    config = function()
      require('minuet').setup({
        -- Local qwen2.5-coder:7b supports FIM, so use the fast insert endpoint.
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 512,
        provider_options = {
          openai_fim_compatible = {
            api_key = 'TERM', -- Ollama needs no key; any existing env var name works
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:7b',
            optional = {
              max_tokens = 128,
              top_p = 0.9,
            },
          },
        },
      })
    end,
  },

  -- OpenCode plugin
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
      vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,       { desc = "Select OpenCode…" })

      vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Append range to OpenCode", expr = true })
      vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Append line to OpenCode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll OpenCode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })
    end,
  },

  -- Completion framework
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "milanglacier/minuet-ai.nvim",
    },
    config = function()
      require('completion')
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
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          separator_style = "slant",
          indicator = { style = "underline" },
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          hover = { enabled = true, delay = 150, reveal = { "close" } },
          show_buffer_close_icons = true,
          show_close_icon = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
  },
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
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal: float" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "Terminal: horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal: vertical" },
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],   -- toggle from normal or terminal mode
        direction = "float",
        float_opts = { border = "curved" },
        shade_terminals = true,
        start_in_insert = true,
        persist_mode = true,
      })
      -- double-Esc drops to normal mode (single Esc still reaches TUIs like lazygit)
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function()
          vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]],
            { buffer = 0, desc = "Terminal: normal mode" })
          -- gd on a `path:line:col` (e.g. a Rust error) jumps to that spot.
          vim.keymap.set("n", "gd", require("term_goto").goto_location,
            { buffer = 0, desc = "Terminal: goto file:line under cursor" })
        end,
      })
    end,
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
