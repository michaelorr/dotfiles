-- minuet-ai.nvim pointed at llama.cpp
--
-- Server (run separately):
--   llama-server --fim-qwen-7b-default
--   llama-server --fim-qwen-30b-default

return {
  {
    "milanglacier/minuet-ai.nvim",
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 4096,
      debounce = 1000,
      virtualtext = {
        auto_trigger_ft = { "*" },
        keymap = {
          accept = "<A-A>",
          accept_line = "<A-a>",
          next = "<A-]>",
          prev = "<A-[>",
          dismiss = "<A-e>",
        },
      },
      provider_options = {
        openai_fim_compatible = {
          -- minuet insists on reading a key from an env var. TERM always
          -- exists in a terminal session, so it's a harmless dummy.
          api_key = "TERM",
          name = "Llama.cpp",
          end_point = "http://localhost:8012/v1/completions",
          model = "PLACEHOLDER",

          optional = {
            max_tokens = 32,
            top_p = 0.9,
          },

          -- llama.cpp's /v1/completions has no `suffix` parameter, so the FIM
          -- tokens get assembled by hand. These tokens are identical across
          -- Qwen2.5-Coder and Qwen3-Coder, so this works for both presets.
          template = {
            prompt = function(context_before_cursor, context_after_cursor, _)
              return "<|fim_prefix|>"
                .. context_before_cursor
                .. "<|fim_suffix|>"
                .. context_after_cursor
                .. "<|fim_middle|>"
            end,
            suffix = false,
          },
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = { "milanglacier/minuet-ai.nvim" },
    opts = function(_, opts)
      table.insert(opts.sources.default, "minuet")
      opts.sources.providers.minuet = {
        name = "minuet",
        module = "minuet.blink",
        async = true,
        timeout_ms = 3000,
        score_offset = 50,
      }
      opts.completion.menu.auto_show = false
      -- minuet's own virtualtext frontend owns the ambient inline suggestion;
      -- blink's ghost_text would otherwise double up on the same preview.
      opts.completion.ghost_text.enabled = false
      return opts
    end,
  },
}
