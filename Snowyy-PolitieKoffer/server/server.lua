AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^3" .. GetCurrentResourceName() .. " ^7Snowyy-Politiekoffer file is klaar voor Gebruik")
    end
end)