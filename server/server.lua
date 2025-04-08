local inventory = exports.ox_inventory

lib.callback.register('mira_mechanic:removevehicledoor', function(source)
    inventory:RemoveItem(source, 'vehicledoor', 1)
end)

lib.callback.register('mira_mechanic:removefixbox', function(source)
    inventory:RemoveItem(source, 'fixbox', 1)
end)

lib.callback.register('mira_mechanic:removevehiclewheel', function(source)
    inventory:RemoveItem(source, 'vehiclewheel', 1)
end)
