-- spec/mate_spec.lua
---@brief
---@date 2025-12-16

local assert = require('luassert')

describe('mate', function()
  local mt = {
    __add = function(a, b)
      return { x = a.x + b.x, y = a.y + b.y }
    end,
    __sub = function(a, b)
      return { x = a.x - b.x, y = a.y - b.y }
    end,
    __mul = function(a, b)
      return { x = a.x * b.x, y = a.y * b.y }
    end,
    __div = function(a, b)
      return { x = a.x / b.x, y = a.y / b.y }
    end,
    __mod = function(a, b)
      return { x = a.x % b.x, y = a.y % b.y }
    end,
    __pow = function(a, b)
      return { x = a.x ^ b.x, y = a.y ^ b.y }
    end,
    __unm = function(a)
      return { x = -a.x, y = -a.y }
    end,
    __concat = function(a, b)
      return { x = a.x .. b.x, y = a.y .. b.y }
    end,
    __eq = function(a, b)
      return a.x == b.x and a.y == b.y
    end,
    __lt = function(a, b)
      return (a.x < b.x) and (a.y < b.y)
    end,
    __le = function(a, b)
      return (a.x <= b.x) and (a.y <= b.y)
    end,
    __tostring = function(a)
      return string.format('(%d, %d)', a.x, a.y)
    end,
    __index = function(a, key)
      if key == 'magnitude' then
        return math.sqrt(a.x * a.x + a.y * a.y)
      end
    end,
    __newindex = function(a, key, value)
      error('Attempt to modify read-only table')
    end,
    __call = function(a)
      return '{ x = ' .. a.x .. ', y = ' .. a.y .. ' }'
    end,
  }

  local foo = { name = 'foo', reserve = nil, x = 3, y = 4 }
  setmetatable(foo, mt)

  it('add + operator', function()
    local bar = { x = 1, y = 2 }

    assert.are.same(foo + bar, { x = 4, y = 6 })

    local baz = foo + bar
    assert.are.same(baz.x, 4)
    assert.are.same(baz.y, 6)
  end)

  it('call () operator', function()
    foo()

    assert.are.same(foo(), '{ x = 3, y = 4 }')
  end)

  it('pow ^ operator', function()
    local bar = { x = 2, y = 3 }

    -- 3^2 = 9, 4^3 = 64
    assert.are.same(foo ^ bar, { x = 9, y = 64 })
  end)
end)
