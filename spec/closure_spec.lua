-- spec/closure_spec.lua
---@brief
---@date 2025-12-16

local assert = require('luassert')

describe("closure", function()
  it('custom for in', function()
    local function get_iterator(array)
      local index = 0
      local count = #array

      return function()
        index = index + 1
        if index > count then
          return nil
        end

        return index, array[index]
      end
    end

    local fruits = { 'apple', 'banana', 'cherry' }

    for i, v in get_iterator(fruits) do
      assert.are.same(fruits[i], v)
    end
  end)
end)
