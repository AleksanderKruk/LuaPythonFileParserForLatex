
local myutils = {}

function myutils.PrintDict(dictionary)
    for key, value in pairs(dictionary) do
        print(key .. " : " .. value)
    end
end


function myutils.PrintDictOfDicts(dictionary)
    for key, value in pairs(dictionary) do
        print(key)
        myutils.PrintDict(value)
    end
end

return myutils