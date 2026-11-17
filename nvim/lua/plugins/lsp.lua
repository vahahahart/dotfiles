return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },

  config = function()
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Документацию под курсором пусть показывает ty.
        if client and client.name == "ruff" then
          client.server_capabilities.hoverProvider = false
        end

        local function map(key, action, description)
          vim.keymap.set("n", key, action, {
            buffer = event.buf,
            desc = description,
          })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("K", vim.lsp.buf.hover, "Show documentation")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
        map("<leader>f", function()
          vim.lsp.buf.format({
            bufnr = event.buf,
            filter = function(format_client)
              if vim.bo[event.buf].filetype == "python" then
                return format_client.name == "ruff"
              end
              return true
            end,
          })
        end, "Format file")
      end,
    })

    local function project_server(name)
      vim.lsp.config(name, {
        root_dir = function(bufnr, on_dir)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          if filename == "" then
            return
          end

          local root = vim.fs.root(bufnr, { "pyproject.toml" })
          or vim.fs.dirname(filename)

          on_dir(root)
        end,

        cmd = function(dispatchers, config)
          local executable = config.root_dir .. "/.venv/bin/" .. name
          local command

          if vim.fn.executable(executable) == 1 then
            command = { executable, "server" }
          else
            command = { "uv", "tool", "run", name, "server" }
          end

          return vim.lsp.rpc.start(command, dispatchers, {
            cwd = config.root_dir,
          })
        end,
      })
    end

    project_server("ty")
    project_server("ruff")

    vim.lsp.enable({ "ty", "ruff", "rust_analyzer" })
  end,
}

