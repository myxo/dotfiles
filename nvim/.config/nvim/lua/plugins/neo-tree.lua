-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          -- auto close
          require("neo-tree.command").execute({ action = "close" })
        end
      },
    }
  },
}
