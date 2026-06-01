-- Установка lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Leader
vim.g.mapleader = " "

-- Основы
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.scrolloff = 8
vim.opt.encoding = "utf-8"

-- Отступы
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Поиск
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Внешний вид
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.laststatus = 2
vim.opt.showmode = true

-- Мышь и буфер обмена
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Курсор
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20"

-- Статусбар
--vim.opt.statusline = "%f%m%r%h%w [%Y] %= %l/%L col:%c"

-- Сброс подсветки поиска по Esc
vim.keymap.set('n', '<Esc>', ':nohl<CR><Esc>', { silent = true })

-- Навигация между сплитами
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Автозакрытие скобок
vim.keymap.set('i', '(', '()<Left>')
vim.keymap.set('i', '[', '[]<Left>')
vim.keymap.set('i', '{', '{<CR>}<Esc>O')
vim.keymap.set('i', '"', '""<Left>')
vim.keymap.set('i', "'", "''<Left>")

-- Подсветка строки курсора
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#45475a' })

-- Плагины
require("lazy").setup({
    -- Molten Nvim for working with python via nvim
    {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    config = function()
        vim.g.molten_auto_open_output = false
        vim.g.molten_image_provider = "kitty"

        vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>', { silent = true })
        vim.keymap.set('n', '<leader>me', ':MoltenEvaluateLine<CR>', { silent = true })
        vim.keymap.set('v', '<leader>me', ':<C-u>MoltenEvaluateVisual<CR>', { silent = true })
        vim.keymap.set('n', '<leader>mr', ':MoltenReevaluateCell<CR>', { silent = true })
        vim.keymap.set('n', '<leader>md', ':MoltenDelete<CR>', { silent = true })
        vim.keymap.set('n', '<leader>mo', ':MoltenShowOutput<CR>', { silent = true })
    end,
    },
    -- Цветовая схема Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({ flavour = "mocha" })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    -- Tree-sitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup({
                ensure_installed = { "lua", "python", "javascript", "bash", "json", "yaml" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set('n', '<leader>ff', builtin.find_files)
            vim.keymap.set('n', '<leader>fg', builtin.live_grep)
            vim.keymap.set('n', '<leader>fb', builtin.buffers)
            vim.keymap.set('n', '<leader>fh', builtin.help_tags)
        end,
    },

    -- nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
        end,
    },
    -- Mason — менеджер LSP серверов
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls" },
            })
        end,
    },

    -- LSP конфиг
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config('lua_ls', { capabilities = capabilities })
            vim.lsp.config('pyright', { capabilities = capabilities })
            vim.lsp.config('ts_ls', { capabilities = capabilities })
            vim.lsp.config('bashls', { capabilities = capabilities })

            vim.lsp.enable({ 'lua_ls', 'pyright', 'ts_ls', 'bashls' })

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
        end,
    },
    -- Автодополнение
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin-mocha",
                },
            })
        end,
    },
})

