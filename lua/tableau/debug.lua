local M = {}

function M.dump(o, pre)
   if type(o) == 'table' then
      local s = '{ \n' .. pre
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v, pre .. '  ') .. ',\n' .. pre
      end
      return s .. '}'
   else
      return tostring(o) .. ','
   end
end

function M.print_table(t)
   print(M.dump(t, '  '))
end

return M
