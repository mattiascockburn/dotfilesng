local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim", -- Easily comment stuff
  -- Better buffer delete behaviour
  -- This plugin provides Bdelete and Bwipeout
  "moll/vim-bbye",
  'rgroli/other.nvim',                   -- easily load corresponding files, e.g. unit tests
  "nvim-lualine/lualine.nvim",           -- enhanced status line plugin
  { 'pnx/lualine-lsp-status' },
  "lewis6991/impatient.nvim",            -- cache lua plugins and reduce load times significantly
  "lukas-reineke/indent-blankline.nvim", -- visualize indentation of lines
  -- Easily align text
  -- used by puppet-vim
  "godlygeek/tabular",
  -- Highlight ugly extra whitespace
  "ntpeters/vim-better-whitespace",
  -- tpope FTW
  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  "tpope/vim-endwise",
  "tpope/vim-speeddating",
  "tpope/vim-eunuch",
  -- Languages
  -- syntax/indent/ftplugins for a many languages/tools
  "hashivim/vim-terraform",
  "lifepillar/pgsql.vim",
  "neomutt/neomutt.vim",
  -- git helpers
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua",       -- optional
    },
    config = true
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true,
  }, -- git conflict resolution
  -- Open file under cursor with 'gf'
  "amix/open_file_under_cursor.vim",
  -- ctags helper, this one seems to be the simplest for
  -- noobs like myself
  "ludovicchabant/vim-gutentags",
  -- Easily align text according to a chosen seperator
  "junegunn/vim-easy-align",
  -- Saner match highlighting and search mappings
  "wincent/loupe",
  -- Colorschemes
  {
    "killitar/obscure.nvim",
    lazy = false,
    priority = 1000,
    opts = {}
  },
  {
    'paulo-granthon/hyper.nvim',
    config = function()
      require('hyper').load()
    end
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave",  -- Load "wave" theme when 'background' option is not set
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      })
    end
  },
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
    end
  },
  "folke/tokyonight.nvim",
  "EdenEast/nightfox.nvim",
  -- cmp plugins
  "hrsh7th/nvim-cmp",          -- The completion plugin
  "hrsh7th/cmp-buffer",        -- buffer completions
  "FelipeLema/cmp-async-path", -- async path completions
  "hrsh7th/cmp-cmdline",       -- cmdline completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  -- File Management Helpers
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require 'window-picker'.setup()
    end,
  },
  -- nifty filesystem editing
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", function() vim.api.nvim_command("Oil") end, { desc = "Open parent directory" })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  --- Alternative to vim-surround with treesitter support
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- YAML helper
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- snippets
  "L3MON4D3/LuaSnip",             -- nice snippet engine, latest major release
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  "honza/vim-snippets",           -- even more snippets
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  },

  -- Markdown preview
  {
    'brianhuster/live-preview.nvim',
    dependencies = { 'brianhuster/autosave.nvim' }, -- Not required, but recomended for autosaving and sync scrolling
    opts = {
      commands = {
        start = 'LivePreview', -- Command to start the live preview server and open the default browser.
        stop = 'StopPreview',  -- Command to stop the live preview.
      },
      port = 5500,             -- Port to run the live preview server on.
      browser = 'default',     -- Terminal command to open the browser for live-previewing (eg. 'firefox', 'flatpak run com.vivaldi.Vivaldi'). By default, it will use the default browser.
      dynamic_root = false,    -- If true, the plugin will set the root directory to the previewed file's directory. If false, the root directory will be the current working directory (`:lua print(vim.uv.cwd())`).
      sync_scroll = false,     -- If true, the plugin will sync the scrolling in the browser as you scroll in the Markdown files in Neovim.
    },
  },
  -- Markdown helper
  -- key mappings are defined in `ftplugin/markdown.lua`
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  "allen-mack/nvim-table-md",
  {
    'SCJangra/table-nvim',
    ft = 'markdown',
    opts = {
      padd_column_separators = true,   -- Insert a space around column separators.
      mappings = {                     -- next and prev work in Normal and Insert mode. All other mappings work in Normal mode.
        next = '<TAB>',                -- Go to next cell.
        prev = '<S-TAB>',              -- Go to previous cell.
        insert_row_up = '<A-k>',       -- Insert a row above the current row.
        insert_row_down = '<A-j>',     -- Insert a row below the current row.
        move_row_up = '<A-S-k>',       -- Move the current row up.
        move_row_down = '<A-S-j>',     -- Move the current row down.
        insert_column_left = '<A-h>',  -- Insert a column to the left of current column.
        insert_column_right = '<A-l>', -- Insert a column to the right of current column.
        move_column_left = '<A-S-h>',  -- Move the current column to the left.
        move_column_right = '<A-S-l>', -- Move the current column to the right.
        insert_table = '<A-t>',        -- Insert a new table.
        insert_table_alt = '<A-S-t>',  -- Insert a new table that is not surrounded by pipes.
        delete_column = '<A-d>',       -- Delete the column under cursor.
      }
    },
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile", "BufEnter" } },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  "tamago324/nlsp-settings.nvim",    -- language server settings defined in json for
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "b0o/schemastore.nvim",            -- schemastore.org for json schemas in jsonls
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>ss", "<cmd>lua require('yaml-companion').open_ui_select()<cr>", { noremap = true })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  "folke/lsp-colors.nvim",         -- add LSP colors for colorschemes that don't yet support them
  "ap/vim-css-color",
  "lukas-reineke/lsp-format.nvim", -- autoformat using Language servers on write
  "RRethy/vim-illuminate",         -- illuminate current keyword in buffer

  -- DAP / Debug Adapter Protocol related plugins
  "nvim-neotest/nvim-nio", -- dep for some other stuff like dap-ui
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    }
  },
  -- Higlight current breakpoint/point in debugging
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {
      "mfussenegger/nvim-dap"
    },
  },
  'leoluz/nvim-dap-go',           -- requires delve
  'mfussenegger/nvim-dap-python', -- requires debugpy https://github.com/microsoft/debugpy
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-context",
  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  },
  "wellle/targets.vim", -- Add support for more text targets
  -- Scalpel: better word replacer within a file
  -- invoked with <Leader>e by default
  "wincent/scalpel",
  -- Go kickstart
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- Git
  "lewis6991/gitsigns.nvim",
  "rhysd/git-messenger.vim",
  "direnv/direnv.vim",         -- direnv integration
  "AndrewRadev/splitjoin.vim", -- change between one line and multiline statements with gJ and gS
  -- decode/encode base64 directly in vim
  { 'taybart/b64.nvim' },
  -- kustomize support
  {
    "allaman/kustomize.nvim",
    requires = "nvim-lua/plenary.nvim",
    ft = "yaml",
    opts = {
      enable_key_mappings = false,
      enable_lua_snip = true,
      validate = { kubeconform_args = { "--strict" } },
      build = { additional_args = { "--enable-helm" } },
    },
    config = function(opts)
      require('kustomize').setup({ opts })
      -- default keybindings, adjust to your needs
      vim.keymap.set("n", "<leader>kb", "<cmd>lua require('kustomize').build()<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>kk", "<cmd>lua require('kustomize').kinds()<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>kl", "<cmd>lua require('kustomize').list_resources()<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>kp", "<cmd>lua require('kustomize').print_resources()<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>kv", "<cmd>lua require('kustomize').validate()<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>kd", "<cmd>lua require('kustomize').deprecations()<cr>", { noremap = true })
    end,
  },
  "akinsho/toggleterm.nvim",
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup(
        {
          excluded_filetypes = { "toggleterm" },
          excluded_buftypes = { "help" }
        }
      )
    end
  },
  -- automatically create annotations for a multitude of languages
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- adapters
      "nvim-neotest/neotest-go",
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        icons = {
          passed = "✅",
          running = "🥁",
          failed = "❌",
          skipped = "⏩",
          unknown = "❓",
        },
        adapters = {
          require("neotest-go"),
        },
      })
    end,
  },
  -- Terminal
  {
    'rebelot/terminal.nvim',
    config = function()
      require("terminal").setup()
      local term_map = require("terminal.mappings")
      vim.keymap.set({ "n", "x" }, "<leader>ts", term_map.operator_send, { expr = true })
      vim.keymap.set("n", "<leader>to", term_map.toggle)
      vim.keymap.set("n", "<leader>tO", term_map.toggle({ open_cmd = "enew" }))
      vim.keymap.set("n", "<leader>tr", term_map.run)
      vim.keymap.set("n", "<leader>tR", term_map.run(nil, { layout = { open_cmd = "enew" } }))
      vim.keymap.set("n", "<leader>tk", term_map.kill)
      vim.keymap.set("n", "<leader>t]", term_map.cycle_next)
      vim.keymap.set("n", "<leader>t[", term_map.cycle_prev)
      vim.keymap.set("n", "<leader>tl", term_map.move({ open_cmd = "belowright vnew" }))
      vim.keymap.set("n", "<leader>tL", term_map.move({ open_cmd = "botright vnew" }))
      vim.keymap.set("n", "<leader>th", term_map.move({ open_cmd = "belowright new" }))
      vim.keymap.set("n", "<leader>tH", term_map.move({ open_cmd = "botright new" }))
      vim.keymap.set("n", "<leader>tf", term_map.move({ open_cmd = "float" }))

      -- This trips me up more than it helps
      -- vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
      --   callback = function(args)
      --     if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
      --       vim.cmd("startinsert")
      --     end
      --   end,
      -- })
    end
  },
  -- AI bullshit
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        providers = {
          ollama = {
            endpoint = "https://ai.iits.tech/backend/api/chat/completions",
            secret = {
              "bash",
              "-c",
              "gopass",
              "show",
              "-o",
              "iits/ai/api"
            }
          },

        },
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
