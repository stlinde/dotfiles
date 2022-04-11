local actions = require("telescope.actions")

require('telescope').setup {
  defaults = {

    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },

    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    },

	file_browser = {
      -- theme = "ivy",
	},
  },
}

-- Loading file_browser and media_files extenstions
require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'media_files'


-- Creating PDF Selector
local M = {}

-- Opening the PDF
local function open_pdf(content)
    vim.fn.system(
        "zathura "
        .. content
        .. " &"
    )
end


local function find_pdf(prompt_bufnr, map)
    local function open_the_pdf(close)
        local content = require('telescope.actions.state').get_selected_entry(
            prompt_bufnr
        )
        open_pdf(content.cwd .. "/" .. content.value)
        if close then
           require('telescope.actions').close(prompt_bufnr)
        end
    end

    map("i", "<CR>", function()
        open_the_pdf(true)
    end)

    map("n", "<CR>", function()
        open_the_pdf(true)
    end)
end

local function pdf_select(prompt, cwd)
    return function()
        require('telescope.builtin').find_files({
            prompt_title = prompt,
            cwd = cwd,

            attach_mappings = function(prompt_bufnr, map)
                find_pdf(prompt_bufnr, map)

                -- Please continue mapping (attaching additional keymaps)
                return true
            end,
        })
    end
end

M.pdf_selector = pdf_select("< Find PDF > ", "~/Documents/Library")

local function note_find(prompt, cwd)
    return function()
        require('telescope').extensions.file_browser.file_browser({
            prompt_title = prompt,
            cwd = cwd,

        })
    end
end

M.note_finder = note_find("< Find Note >", "~/Documents/Notes")

return M




