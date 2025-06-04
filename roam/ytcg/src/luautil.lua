-- Module Definition

-- [[file:../../20241221205601-cg_lua_util.org::*Module Definition][Module Definition:1]]
luautil = {}

function luautil.reverse(tab)
   local result = {}
   for i = #tab, 1, -1 do
       table.insert(result, tab[i])
   end 
   return result
end

function luautil.remove_hole(tab)
   local result = {}
   local len = #tab
   for i = 1, len do
      if tab[i] then
         table.insert(result, tab[i])
      end
   end
   return result
end

return luautil
-- Module Definition:1 ends here
