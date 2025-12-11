-- spec/helper_spec.lua

local assert = require('luassert')
local helper = require('helper')

describe("helper", function()
  it('table equal', function()
    local t1 = { a = 1, b = 2, c = { d = 3, e = 4 } }
    local t2 = { a = 1, b = 2, c = { d = 3, e = 4 } }
    assert.are.same(helper.tbl_equal(t1, t2), true)
  end)

  it('table not equal', function()
    local t1 = { a = 1, b = 2, c = { d = 3, e = 5 } }
    local t2 = { a = 1, b = 2, c = { d = 4, e = 5 } }
    assert.are.same(helper.tbl_equal(t1, t2), false)
  end)

  it('string trim', function()
    local s1 = '\n\r\t\v\f hello \n\r\t\v\f'

    assert.are.same(helper.trim(s1), 'hello')
    assert.are.same(helper.trim_left(s1), 'hello \n\r\t\v\f')
    assert.are.same(helper.trim_right(s1), '\n\r\t\v\f hello')
  end)

  it('json decode', function()
    local s1 = [[
    { "user": { "bar": [ 1, 2, 3 ] } }
    ]]

    local d1 = vim.json.decode(s1)
    assert.is_not.Nil(d1, nil)

    assert.is.table(d1)
    assert.is.table(d1.user)
    assert.is.table(d1.user.bar)
    assert.is.table(d1['user'])
    assert.is.table(d1['user']['bar'])

    assert.is.Nil(d1.noex)

    -- for _, v in ipairs(d1.user.bar) do
    --   print(v)
    -- end
  end)
end)
