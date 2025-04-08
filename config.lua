Config = {}

Config.Language = 'en' -- Options - 'cs', 'en'

Config.ItemNames = {
    ['fixtool'] = 'screwdriver',
    ['fixbox'] = 'fixbox',
    ['sponge'] = 'sponge',
    ['vehicledoor'] = 'vehicledoor',
    ['vehiclewheel'] = 'vehiclewheel',
}

Config.RepairTime = 2000
Config.WashTime = 2000

Config.Locales = {
    -- Target
    ['target-repair'] = 'Repair Vehicle',
    ['target-wash'] = 'Wash Vehicle',
    -- Repair Outside Motorworks
    ['engine'] = 'Engine',
    ['body'] = 'Body',
    ['petrol'] = 'Petrol Tank',
    ['tomuchdestroyed'] = 'This vehicle has too much damage to repair outside the workshop. Affected part: ',
    -- Others
    ['vehiclerepair'] = 'Vehicle Repair',
    ['outvehicle'] = 'You have to get out of the vehicle',
    ['mistake'] = 'You were clumsy and failed to repair your vehicle',
    ['success'] = 'You have successfully repaired your vehicle',
    ['novehicles'] = 'There is no vehicle nearby',
    ['cannotrepair'] = 'The vehicle cannot be repaired here',
    ['cannotwash'] = 'The vehicle cannot be washed here',
    ['norepairhere'] = 'You cannot currently repair your vehicle',
    ['nowashhere'] = 'You cannot currently wash your vehicle',
    -- Item Needs
    ['needfixtool'] = 'To repair the vehicle, you need at least a fixtool',
    ['needfixbox'] = 'To repair the vehicle, you also need to have a fixbox',
    ['needvehicledoor'] = 'To repair the vehicle, you also need to have a vehicle door. You will need this amount: ',
    ['needvehiclewheel'] = 'To repair the vehicle, you also need to have a vehicle wheel. You will need this amount: ',
    ['needsponge'] = 'To repair the vehicle, you need at least a sponge',
    -- Progressbar
    ['progress-repair'] = 'Repairing vehicle',
    ['progress-wash'] = 'Washing vehicle'   
}

-- Config.Locales['X']