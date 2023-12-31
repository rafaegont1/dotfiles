local config = function()
  -- import mason
  local mason = require("mason")

  -- import mason-lspconfig
  local mason_lspconfig = require("mason-lspconfig")

  --local mason_tool_installer = require("mason-tool-installer")

  -- enable mason and configure icons
  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  local keymap = vim.keymap -- for conciseness

  local opts = { noremap = true, silent = true }
  local on_attach = function(_, bufnr)
    opts.buffer = bufnr

    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>E", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "<leader>j", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

    opts.desc = "Signature Documentation"
    keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, opts)
  end

  -- import cmp-nvim-lsp plugin
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local capabilities = cmp_nvim_lsp.default_capabilities()

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        --settings = servers[server_name],
        --filetypes = (servers[server_name] or {}).filetypes,
      }
    end,
  }

  --mason_lspconfig.setup({
  --  -- list of servers for mason to install
  --  ensure_installed = {
  --    "clangd",
  --  },
  --  -- auto-install configured servers (with lspconfig)
  --  --automatic_installation = true, -- not the same as ensure_installed
  --})

  --mason_tool_installer.setup({
  --  ensure_installed = {
  --    "prettier", -- prettier formatter
  --    "stylua", -- lua formatter
  --    "isort", -- python formatter
  --    "black", -- python formatter
  --    "pylint", -- python linter
  --    "eslint_d", -- js linter
  --  },
  --})
end

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    --"WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = config,
}
