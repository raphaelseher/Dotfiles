local function configure_ale()
  -- Disable language server integration
  vim.g.ale_disable_lsp = 1

  -- Set the linters to use for various file types
  vim.g.ale_linters = {
    python = {'pyright'},
    php = {'phpcbf', 'php_cs_fixer'},
    vim = {'vint'},
    cpp = {'cpplint', 'cppcheck', 'clangtidy', 'clazy'},
  }

  -- Enable automatic fixing on save
  vim.g.ale_fix_on_save = 1

  -- Set the fixers to use for various file types
  vim.g.ale_fixers = {
    ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
    javascript = {'prettier', 'eslint'},
    cpp = {'clang-format'},
  }

  -- Enable signs in the sign column
  vim.g.ale_sign_column_always = 1

  -- Echo the cursor position on lint errors
  vim.g.ale_echo_cursor = 1

  -- Set the sign characters for errors and warnings
  vim.g.ale_sign_error = 'E>'
  vim.g.ale_sign_warning = 'W-'
end

configure_ale()

