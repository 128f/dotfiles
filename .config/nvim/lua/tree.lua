-- nvim-tree file explorer. See `:help nvim-tree.OPTION_NAME`.
require'nvim-tree'.setup {
  disable_netrw  = true,
  hijack_netrw   = true,
  hijack_cursor  = false,
  sync_root_with_cwd = true,

  -- Surface LSP errors/warnings next to files in the tree.
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint    = "󰌶",
      info    = "",
      warning = "",
      error   = "",
    },
  },

  -- Reveal and highlight the file you're editing.
  update_focused_file = {
    enable = true,
    update_root = false,
  },

  filters = {
    dotfiles = false,
    custom = {},
  },

  git = {
    enable  = true,
    ignore  = true,
    timeout = 500,
  },

  view = {
    width  = 32,
    side   = 'left',
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },

  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = { file = true, folder = true, folder_arrow = true, git = true },
    },
  },

  actions = {
    change_dir = { global = false },
    open_file  = { quit_on_open = false },
  },

  trash = {
    cmd = "trash",
  },
}
