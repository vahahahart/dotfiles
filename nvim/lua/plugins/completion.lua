return {
  "saghen/blink.cmp",
  version = "1.*",

  opts = {
    keymap = {
      preset = "super-tab",
      ["<CR>"] = { "accept", "fallback" },
    },

    completion = {
      trigger = {
        show_on_keyword = true,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },

    sources = {
      default = { "lsp", "path", "buffer" },
    },

    fuzzy = {
      implementation = "lua",
    },
  },
}
