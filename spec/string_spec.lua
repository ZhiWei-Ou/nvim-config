-- spec/string_spec.lua
---@brief
---@date 2025-12-16
local assert = require('luassert')

describe("string", function()
  it('length use `#string` or `string.len`', function()
    local s1 = 'helloworld'
    assert.are.same(#s1, 10)
    assert.are.same(string.len(s1), 10)
  end)

  it('upper and lower use `string.upper` or `string.lower`', function()
    assert.are.same(string.upper('helloworld'), 'HELLOWORLD')
    assert.are.same(string.lower('HELLOWORLD'), 'helloworld')
  end)

  it('replace use `string.gsub`', function()
    local s = 'foo is foo and foo'

    ---@brief Replace all occurrences of 'foo' with 'bar'
    assert.are.same(string.gsub(s, 'foo', 'bar'), 'bar is bar and bar')

    ---@brief Replace only the first occurrence of 'foo' with 'bar'
    assert.are.same(string.gsub(s, 'foo', 'bar', 1), 'bar is foo and foo')

    ---@brief Replace only the first two occurrences of 'foo' with 'bar'
    assert.are.same(string.gsub(s, 'foo', 'bar', 2), 'bar is bar and foo')
  end)

  it('find(support regex pattern) use `string.find`', function()
    local s = 'hello world'
    local start_idx, end_idx = string.find(s, 'world')
    assert.are.same(start_idx, 7)
    assert.are.same(end_idx, 11)

    -- Not found case
    local not_found_start, not_found_end = string.find(s, 'lua')
    assert.are.same(not_found_start, nil)
    assert.are.same(not_found_end, nil)

    -- Use regex pattern
    local pattern_start, pattern_end = string.find(s, 'h%a+')
    assert.are.same(pattern_start, 1)
    assert.are.same(pattern_end, 5)
  end)

  it('reverse use `string.reverse`', function()
    assert.are.same(string.reverse('hello'), 'olleh')
  end)

  it('format use `string.format`', function()
    local name = 'world'
    local greeting = string.format('hello, %s!', name)
    assert.are.same(greeting, 'hello, world!')
  end)

  it('sub use `string.sub`', function()
    -- hello world
    -- 12345678901
    local s = 'hello world'

    -- hello world
    -- 1...5678901
    assert.are.same(string.sub(s, 1, 5), 'hello')

    -- hello world
    -- 1234567....
    assert.are.same(string.sub(s, 7), 'world')
    assert.are.same(string.sub(s, -5), 'world')
  end)
end)
