-- https://github.com/lifepillar/vim-gruvbox8?
--
-- ansi_00    #665c54
-- ansi_01    #cc241d
-- ansi_02    #98971a
-- ansi_03    #d79921
-- ansi_04    #458588
-- ansi_05    #b16286
-- ansi_06    #689d6a
-- ansi_07    #a89984
-- ansi_08    #7c6f64
-- ansi_09    #fb4934
-- ansi_10    #b8bb26
-- ansi_11    #fabd2f
-- ansi_12    #83a598
-- ansi_13    #d3869b
-- ansi_14    #8ec07c
-- ansi_15    #bdae93

------------------------------------------------------------------------------------------------------
--   dark0_hard       = "#1d2021",
--   dark0            = "#282828", / background / cursor_text_color
--   dark0_soft       = "#32302f",
--   dark1            = "#3c3836", / inactive_tab_background
--   dark2            = "#504945",
--   dark3            = "#665c54", / black / bg3 / ansi_0 / inactive_border_color / active_tab_background
--   dark4            = "#7c6f64", / black / bg4 / ansi_8

--   light0_hard      = "#f9f5d7",
--   light0           = "#fbf1c7", / active_tab_foreground
--   light0_soft      = "#f2e5bc",
--   light1           = "#ebdbb2", / foreground / selection_bg
--   light2           = "#d5c4a1",
--   light3           = "#bdae93", / white / fg3 / ansi_15
--   light4           = "#a89984", / white / fg4 / ansi_7 / inactive_tab_foreground

--   bright_red       = "#fb4934", / red    / ansi_9
--   bright_green     = "#b8bb26", / green  / ansi_10
--   bright_yellow    = "#fabd2f", / yellow / ansi_11
--   bright_blue      = "#83a598", / blue   / ansi_12 / url_color
--   bright_purple    = "#d3869b", / purple / ansi_13 / active_border_color
--   bright_aqua      = "#8ec07c", / cyan   / ansi_14 / bell_border_color / visual_bell_color
--   bright_orange    = "#fe8019",

--   neutral_red      = "#cc241d", / red    / ansi_1
--   neutral_green    = "#98971a", / green  / ansi_2
--   neutral_yellow   = "#d79921", / yellow / ansi_3
--   neutral_blue     = "#458588", / blue   / ansi_4
--   neutral_purple   = "#b16286", / purple / ansi_5
--   neutral_aqua     = "#689d6a", / cyan   / ansi_6
--   neutral_orange   = "#d65d0e",

--   faded_red        = "#9d0006",
--   faded_green      = "#79740e",
--   faded_yellow     = "#b57614",
--   faded_blue       = "#076678",
--   faded_purple     = "#8f3f71",
--   faded_aqua       = "#427b58",
--   faded_orange     = "#af3a03",

--    dark_red_hard   = "#792329",
--    dark_red        = "#722529",
--    dark_red_soft   = "#7b2c2f",
--   light_red_hard   = "#fc9690",
--   light_red        = "#fc9487",
--   light_red_soft   = "#f78b7f",

--    dark_green_hard = "#5a633a",
--    dark_green      = "#62693e",
--    dark_green_soft = "#686d43",
--   light_green_hard = "#d3d6a5",
--   light_green      = "#d5d39b",
--   light_green_soft = "#cecb94",

--    dark_aqua_hard  = "#3e4934",
--    dark_aqua       = "#49503b",
--    dark_aqua_soft  = "#525742",
--   light_aqua_hard  = "#e6e9c1",
--   light_aqua       = "#e8e5b5",
--   light_aqua_soft  = "#e1dbac",

--   gray             = "#928374", / cursor / selection_fg

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        terminal_colors = true,
        undercurl = true,
        underline = true,
        underdashed = true,
        underdotted = true,
        underdouble = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        palette_overrides = {},
        dim_inactive = true,
        -- the tmux theme sets a custom dark background, setting this to
        -- transparent allows the darker tmux background to show through
        transparent_mode = true,
        overrides = {
          -- This isn't strictly necessary because of transparent_mode
          -- but reduces the work by vim when drawing empty space
          Normal = { bg = "NONE", fg = "NONE" },
          Todo = { link = "Comment" }, -- Todo highlighting is handled by todo-comments.nvim
          ColorColumn = { bg = "#252527" },
          CursorLineNr = { bg = "#3c3836", fg = "#ebdbb2" },
          NormalMode = { fg = "#ebdbb2" },
          InsertMode = { fg = "#83a598" },

          -- This is not a "real" highlight group, but it is used by the pulse plugin. If
          -- we pulse before the prior timeout finishes, we will get an incorrect
          -- "original" color. This is a hack to make sure we always end where we started.
          OrigCursorLine = { bg = "#3c3836" },
          PulseCursorLine = { bg = "#83a598" },
          CursorLine = { bg = "#3c3836" },
          FoldColumn = { fg = "#ebdbb2", bg = "#3c3836" },
          CopilotSuggestion = { fg = "#83a598", italic = true },
          EndOfBuffer = { fg = "#a89984" },
          -- NonText = { fg = "#458588", bold = true, italic = false },
          InvalidWhitespace = { fg = "#fb4934", bold = false, italic = false },
          Whitespace = { link = "InvalidWhitespace" },
          GoTab = { fg = "#504945" },
          RenderMarkdownH1Bg = { bold = true, fg = "#ebdbb2", bg = "#6f3200", undercurl = true },
          RenderMarkdownH2Bg = { fg = "#86a297", bg = "#25332e", bold = true, italic = true },
          RenderMarkdownH3Bg = { fg = "#c78650", bg = "#532600", bold = true, italic = true },
          RenderMarkdownH4Bg = { fg = "#cd8c9e", bg = "#3f1722", bold = true, italic = true },
        },
      })

      vim.o.background = "dark"

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "gruvbox",
        callback = function()
          vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#fe8019" })
          vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underdotted = true, sp = "#fe8019" })
          vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underdotted = true, sp = "#fe8019" })
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  {
    "mawkler/modicator.nvim",
    dependencies = "ellisonleao/gruvbox.nvim",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {
      highlights = {
        use_cursorline_background = true,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = {
        trunc_marker = { fg = "#83a598" },
        close_button_selected = { fg = "#cc241d" },
        buffer_selected = { fg = "#fbf1c7", bold = true, italic = true },
      },
    },
  },
}
