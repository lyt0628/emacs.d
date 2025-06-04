-- Module Definition
-- Let us use Lua Module to define the Vec type. 

-- [[file:../../20241223072514-cg_vector.org::*Module Definition][Module Definition:1]]
M = {}
M.classid = "Vec"
function M.new(...) 
   if not ...  then
      error("[Vec] Arugment of New() cannot be empty!")
   end
   local elems = {...}
   local vec = {elems = elems}
   setmetatable(vec, M)
   return vec
end
function M:get(idx)
  if(not idx) then
     error("[Vec] Argument idx is required!")
  end
  if(idx > self:size()) then
     error("[Vec] Position_Out_Of_Bound!")
  end
  return self.elems[idx]
end
function M.__index(t, key)
   if(type(key) == "number") then
      -- If not found, nil will be returned.
      return t:get(key)
   elseif (rawget(t, key)) then
      return rawget(t, key)
   else
      -- If syombol not found in child, find it in metatable
      return rawget(M, key)
   end

end
function M:with(idx, value)
  if(not idx) then
     error("[Vec] Argument idx is required!")
  end
  if(idx > self:size()) then
     error("[Vec] Position_Out_Of_Bound!")
  end
  local result = self:clone()
  result.elems[idx] = value

  return result
end
function M:size()
  return #(self.elems)
end
function M.__len(vec)
  local sum = 0
  for i = 1, vec:size() do
     sum = sum + vec[i]
  end
  return math.sqrt(sum)
end
function M:add(other)
  if(self:size() ~= other:size()) then
    error("[Vec] Length of component of Vec must equal!")
  end
  local result = {}
  for i = 1, self:size() do
    result[i] = self:get(i) + other:get(i)
  end
  return M.new(table.unpack(result))
end
function M:sub(other)
  if(self:size() ~= other:size()) then
    error("[Vec] Length of component of Vec must equal!")
  end
  local result = {}
  for i = 1, self:size() do
    result[i] = self[i] - other[i] 
  end
  return M.new(table.unpack(result))
end
function M:mul(other)
  if(self:size() ~= other:size()) then
    error("[Vec] Length of component of Vec must equal!")
  end
  local result = {}
  for i = 1, self:size() do
    result[i] = self[i] * other[i] 
  end
  return M.new(table.unpack(result))
end
function M:div(other)
  if(self:size() ~= other:size()) then
    error("[Vec] Length of component of Vec must equal!")
  end
  local result = {}
  for i = 1, self:size() do
    result[i] = self[i] / other[i] 
  end
  return M.new(table.unpack(result))
end
function M.__add(lhv, rhv)
  -- Vec + Vec
  return lhv:add(rhv)
end
function M.__sub(lhv,rhv)
  -- Vec - Vec
  return lhv:sub(rhv)
end
function M.__div(lhv,rhv)
  -- Vec / Vec
  return lhv:div(rhv)
end
function M:scale(scalar)
  local result = {}
  for i = 1, self:size() do
     result[i]= self.elems[i] * scalar
  end
  return M.new(table.unpack(result))
end
function M.__mul(lhv, rhv)
  if(type(lhv) == "number") then
     return rhv:scale(lhv)
  elseif (type(rhv) == "number") then
     return lhv:scale(rhv)
  end
   -- Vec * Vec
   return lhv:mul(rhv)
end
if(type(lhv) == "number") then
   return rhv:scale(lhv)
elseif (type(rhv) == "number") then
   return lhv:scale(rhv)
end
 function M:dot(other)
  if(self:size() ~= other:size()) then
    error("[Vec] Length of component of Vec must equal!")
  end
  local sum = 0
  for i = 1, self:size() do
     sum = sum + self[i] * other[i]
  end
  return sum
end   
function M:clone()
   local result = {}
   table.move(self.elems, 1, self:size(), 1, result)
   return M.new(table.unpack(result))
end
function M:slice(startIdx, endIdx)
   local elems = {}
   table.move(self.elems, startIdx, endIdx, 1, elems)
   return M.new(table.unpack(elems))
end 
function M:concat(other)
   local elems = {}
   table.move(self.elems, 1, self:size(), 1, elems)
   table.move(other.elems, 1, other:size(), self:size() + 1, elems)
   return M.new(table.unpack(elems))
end 
function M.__concat(lhv, rhv)
   return lhv:concat(rhv)
end
-- Used for location
function M:x() return self[1] end
function M:y() return self[2] end
function M:z() return self[3] end
function M:w() return self[4] end


function M:xy() return M.new(self:x(), self:y()) end
function M:yz() return M.new(self:y(), self:z()) end
function M:zw() return M.new(self:z(), self:w()) end

function M:xyz() return M.new(self:x(), self:y(), self:z()) end
-- Used for color
function M:r() return self[1] end
function M:g() return self[2] end
function M:b() return self[3] end
function M:a() return self[4] end

function M:rgb() return Vec.new(self:r(), self:g(), self:b()) end
-- Used for texture
function M:s() return self[1] end
function M:t() return self[2] end
function M:p() return self[3] end
function M:q() return self[4] end

function M:st() return M.new(self:s(), self:t()) end
function M:pq() return M.new(self:p(), self:q()) end
 function M.cross3(one, other)
  
  local x = one:y() * other:z() - one:z() * other:y()
  local y = one:z() * other:x() - one:x() * other:z()
  local z = one:x() * other:y() - one:y() * other:x()

  return M.new(x, y, z)
end   
return M
-- Module Definition:1 ends here
