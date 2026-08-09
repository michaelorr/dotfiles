return {
  {
    "ggml-org/llama.vim",
    init = function()
      vim.g.llama_config = {
        endpoint_fim = "http://127.0.0.1:8012/infill",

        -- Local window around the cursor, in lines.
        n_prefix = 256,
        n_suffix = 64,

        -- Generation cap. At ~14ms/tok on the 3B this is ~1.8s worst case,
        -- but t_max_predict_ms below is the real bound -- n_predict is just
        -- a ceiling it will rarely reach.
        n_predict = 128,

        t_max_prompt_ms = 500,
        t_max_predict_ms = 700,

        -- Ring buffer: chunks from other open/edited files and yanked text.
        -- This is the capability minuet had no equivalent for. Sent during
        -- inactivity so it costs no per-keystroke latency.
        ring_n_chunks = 16, -- raise toward 32 if quality > latency
        ring_chunk_size = 64,
        ring_scope = 1024,
        ring_update_ms = 1000,

        auto_fim = true,

        -- 2 = inline stats: context used, ring chunks held, prompt tokens
        -- computed, generation time. Leave this on while tuning -- it's the
        -- in-editor version of reading the server log.
        show_info = 2,

        keymap_fim_accept_full = "<A-A>",
        keymap_fim_accept_line = "<A-a>",
        keymap_fim_accept_word = "<A-]>",
        keymap_fim_trigger = "<A-f>",
      }
    end,
  },

  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion.menu.auto_show = false
      opts.completion.ghost_text.enabled = false
      return opts
    end,
  },
}
