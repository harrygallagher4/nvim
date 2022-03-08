-- from: <https://github.com/VrIgHtEr/toolshed.nvim/blob/30c30abe4a0141bcd7a0003827126229459a6373/lua/toolshed/util/string/init.lua#L112-L146>
-- Returns the Levenshtein distance between two strings
---@param self string
---@param B string
---@return number
function string:distance(B)
  local la, lb, x = self:len(), B:len(), {}
  if la == 0 then
    return lb
  end
  if lb == 0 then
    return la
  end
  if la < lb then
    self, la, B, lb = B, lb, self, la
  end
  for i = 1, lb do
    x[i] = i
  end
  for r = 1, la do
    local t, l, v = r - 1, r, self:sub(r, r)
    for c = 1, lb do
      if v ~= B:sub(c, c) then
        if x[c] < t then
          t = x[c]
        end
        if l < t then
          t = l
        end
        t = t + 1
      end
      x[c], l, t = t, t, x[c]
    end
  end
  return x[lb]
end
