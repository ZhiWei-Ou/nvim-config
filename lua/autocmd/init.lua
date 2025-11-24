vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client:supports_method 'textDocument/codeLens' then
      vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end
  end,
})

--[[
local function is_binary_file(path)
    local ok, data = pcall(function()
        local f = io.open(path, "rb")
        if not f then return nil end
        local content = f:read(4096)  -- 检查前 4KB
        f:close()
        return content
    end)

    if not ok or not data then return false end

    local nontext = 0
    local total = #data

    for i = 1, total do
        local byte = data:byte(i)

        -- NULL 字节 → 99% 是 binary
        if byte == 0 then
            return true
        end

        -- 控制字符但不是常见的文本控制符
        if (byte < 9)
        or (byte > 13 and byte < 32)
        then
            nontext = nontext + 1
        end
    end

    -- 超过 10% 非文本字符 → binary
    if nontext / total > 0.1 then
        return true
    end

    return false
end

vim.api.nvim_create_autocmd("BufReadCmd", {
  -- pattern = {
  --   '*.jpg', '*.jpeg', '*.png', '*.gif', '*.bmp', '*.tiff',
  -- },
  callback = function(args)
    local file = vim.fn.expand("%:p")
    if is_binary_file(file) then
      vim.ui.select(
        { 'yes', 'no' },
        {
          prompt = 'The file is binary. Do you want to open it?:',
        },
        function(choice)
          if choice == 'yes' then
            vim.ui.open(file)
          end

          vim.api.nvim_buf_delete(args.buf, { force = true })
          vim.cmd("enew")
        end)
    end
  end,
})
]]
