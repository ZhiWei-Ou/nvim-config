local X = {}

---@brief check file exists
---@param file string
---@return boolean
function X.file_exists(file)
  local f = io.open(file, 'r')
  if f ~= nil then
    f:close()
    return true
  else
    return false
  end
end

---@brief read all of file content
---@param file string
---@return string
function X.file_readall(file)
  local f = assert(io.open(file, 'rb'))
  local content = f:read('*a')
  f:close()
  return content
end

---@brief write content to file
---@param file string
---@param content string
function X.file_write(file, content)
  local f = assert(io.open(file, 'wb'))
  f:write(content)
  f:close()
end

---@brief append content to file
---@param file string
---@param content string
---@return nil
function X.file_append(file, content)
  local f = assert(io.open(file, 'ab'))
  f:write(content)
  f:close()
end

---@brief check table equal
---@param tbl1 table
---@param tbl2 table
---@return boolean
function X.tbl_equal(tbl1, tbl2)
  return vim.deep_equal(tbl1, tbl2)
end

function X.trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function X.trim_left(s)
  return (s:gsub("^%s*(.-)", "%1"))
end

function X.trim_right(s)
  return (s:gsub("(.-)%s*$", "%1"))
end

return X
