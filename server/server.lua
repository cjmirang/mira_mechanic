local inventory = exports.ox_inventory

lib.callback.register('mira_mechanic:removevehicledoor', function(source)
    inventory:RemoveItem(source, Config.ItemNames['vehicledoor'], 1)
end)

lib.callback.register('mira_mechanic:removefixbox', function(source)
    inventory:RemoveItem(source, Config.ItemNames['fixbox'], 1)
end)

lib.callback.register('mira_mechanic:removevehiclewheel', function(source)
    inventory:RemoveItem(source, Config.ItemNames['vehiclewheel'], 1)
end)
