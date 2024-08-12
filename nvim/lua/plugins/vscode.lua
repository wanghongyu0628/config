if vim.g.vscode then
  local enabled = {
    "dial.nvim",
    "flit.nvim",
    "lazy.nvim",
    "leap.nvim",
    "mini.ai",
    "mini.comment",
    "mini.move",
    "mini.pairs",
    "mini.surround",
    "nvim-treesitter",
    "nvim-treesitter-textobjects",
    "nvim-ts-context-commentstring",
    "ts-comments.nvim",
    "vim-repeat",
    "yanky.nvim",
    "LazyVim",
  }

  local Config = require("lazy.core.config")
  Config.options.checker.enabled = false
  Config.options.change_detection.enabled = false
  Config.options.defaults.cond = function(plugin)
    return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
  end
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimKeymapsDefaults",
    callback = function()
      vim.keymap.set("n", "<leader><space>", "<cmd>call VSCodeNotify('whichkey.show')<cr>")
      vim.keymap.set("n", ",", "<cmd>call VSCodeNotify('whichkey.show')<cr>")
      -- vim.keymap.set("n", "<leader>/", [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
      -- vim.keymap.set("n", "<leader>ss", [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
    end,
  })
  return {
    {
      "vscode-neovim/vscode-multi-cursor.nvim",
      event = "VeryLazy",
      cond = not not vim.g.vscode,
      opts = {},
    },
    {
      "mg979/vim-visual-multi",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      cond = not vim.g.vscode,
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      cond = not vim.g.vscode,
    }, 
    {
      "LazyVim/LazyVim",
      config = function(_, opts)
        opts = opts or {}
        -- disable the colorscheme
        opts.colorscheme = function() end
        require("lazyvim").setup(opts)
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = { highlight = { enable = false } },
    },
  }
else
  return {
    {
      "vscode-neovim/vscode-multi-cursor.nvim",
    },
    {
      "mg979/vim-visual-multi",
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      cond = not vim.g.vscode,
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      cond = not vim.g.vscode,
    },
  }
end
