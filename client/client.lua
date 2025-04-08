local dilny = {
    police = {
        vec3(-1133.0077, -3412.1973, 13.9451)
    },
    bennys = {
        vec3(-206.6620, -1323.5500, 31.3005)
    },
    driveline = {
        vec3(-818.4543, -430.5450, 36.6375)
    },
    redline = {
        vec3(-575.1072, -931.8577, 23.8804)
    },
    underground = {
        vec3(-928.2465, -779.0783, 15.0742)
    },
}

exports.ox_target:addGlobalVehicle({
    {
        name  = 'mira_mechanic:RepairVehicle',
        groups = {['police'] = 0, ['redline'] = 0, ['eastcustoms'] = 0},
        icon  = 'fa-solid fa-wrench',
        label = Config.Locales['target-repair'],
        event = 'mira_mechanic:RepairVehicle'
    },
    {
        name  = 'mira_mechanic:WashVehicle',
        groups = {['police'] = 0, ['redline'] = 0, ['eastcustoms'] = 0},
        icon  = 'fa-solid fa-wrench',
        label = Config.Locales['target-wash'],
        event = 'mira_mechanic:WashVehicle'
    }
})


local mechanicveh = {}
local vehicles = { 'flatbed' }

for _, model in ipairs(vehicles) do
    mechanicveh[GetHashKey(model)] = true
end

function CanRepairOutisdeMotorworks(vehicle)
    local checks = {
        { func = GetVehicleEngineHealth,     label = Config.Locales['engine'] },
        { func = GetVehicleBodyHealth,       label = Config.Locales['body'] },
        { func = GetVehiclePetrolTankHealth, label = Config.Locales['petrol'] }
    }

    for _, check in ipairs(checks) do
        if check.func(vehicle) < 600 then
            lib.notify({
                title       =  Config.Locales['vehiclerepair'],
                description =  Config.Locales['tomuchdestroyed'] .. check.label,
                type        = 'error'
            })
            return false
        end
    end

    return true
end

function repairVehicle()
    local coords = GetEntityCoords(cache.ped or PlayerPedId())
    local vehicle = lib.getClosestVehicle(coords, 6.0, false)
    local distance = #(coords - GetEntityCoords(vehicle))

    if cache.vehicle then
        lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['outvehicle'],
            type        = 'error'
        })
        return
    end

    if DoesEntityExist(vehicle) and distance < 6 then
        local engineStatus = GetIsVehicleEngineRunning(vehicle)

        if not isInMotorworks then
            if not CanRepairOutisdeMotorworks(vehicle) then
                return
            end
        end

        local count = exports.ox_inventory:Search('count', Config.ItemNames['fixtool'])
        if count == 0 then
            return lib.notify({
                title       =  Config.Locales['vehiclerepair'],
                description =  Config.Locales['needfixtool'],
                type        = 'error'
            })
        end

        local fixboxRequired = false
        if GetVehicleEngineHealth(vehicle) < 750 then
            fixboxRequired = true

            local fixBoxcount = exports.ox_inventory:Search('count', Config.ItemNames['fixbox'])
            if fixBoxcount == 0 then
                return lib.notify({
                    title       =  Config.Locales['vehiclerepair'],
                    description =  Config.Locales['needfixbox'],
                    type        = 'error'
                })
            end
        end

        local amountOfBrokenDoors = 0
        for cd = 1, 6 do
            local door = IsVehicleDoorDamaged(vehicle, cd - 1)
            if door then
                amountOfBrokenDoors += 1
            end
        end
        if amountOfBrokenDoors > 0 then
            local doorscount = exports.ox_inventory:Search('count', Config.ItemNames['vehicledoor'])
            if doorscount < amountOfBrokenDoors then
                return lib.notify({
                    title       =  Config.Locales['vehiclerepair'],
                    description =  Config.Locales['needvehicledoor'] ..amountOfBrokenDoors,
                    type        = 'error'
                })
            end
        end

        local totalWheelsBroken = 0
        for cd = 1, 7 do
            local tyre1 = IsVehicleTyreBurst(vehicle, cd, true)
            local tyre2 = IsVehicleTyreBurst(vehicle, cd, false)
            if tyre1 or tyre2 then
                totalWheelsBroken += 1
            end
        end
        if totalWheelsBroken > 0 then
            local wheelscount = exports.ox_inventory:Search('count', Config.ItemNames['vehiclewheel'])
            if wheelscount < totalWheelsBroken then
                return lib.notify({
                    title       =  Config.Locales['vehiclerepair'],
                    description =  Config.Locales['needvehiclewheel'] ..totalWheelsBroken,
                    type        = 'error'
                })
            end
        end

        local success = lib.skillCheck({'easy'}, {'w', 'a', 's', 'd'})
        if not success then
            return lib.notify({
                title       =  Config.Locales['vehiclerepair'],
                description =  Config.Locales['mistake'],
                type        = 'error'
            })
        end
        local count = exports.ox_inventory:Search('count', Config.ItemNames['fixtool'])
        if count == 0 then
            return lib.notify({
                title       =  Config.Locales['vehiclerepair'],
                description =  Config.Locales['needfixtool'],
                type        = 'error'
            })
        end

        if fixboxRequired then
            local fixBoxcount = exports.ox_inventory:Search('count', Config.ItemNames['fixbox'])
            if fixBoxcount == 0 then
                return lib.notify({
                    title       =  Config.Locales['vehiclerepair'],
                    description =  Config.Locales['needfixbox'],
                    type        = 'error'
                })
            else
                lib.callback.await('mira_mechanic:removefixbox')
            end
        end

        if amountOfBrokenDoors > 0 then
            local doorscount = exports.ox_inventory:Search('count', Config.ItemNames['vehicledoor'])
            if doorscount < amountOfBrokenDoors then
                return lib.notify({
                    title       =  Config.Locales['vehiclerepair'],
                    description =  Config.Locales['needvehicledoor'] ..amountOfBrokenDoors,
                    type        = 'error'
                })
            else
                for i = 1, amountOfBrokenDoors do
                    lib.callback.await('mira_mechanic:removevehicledoor')
                end
            end
        end

        if totalWheelsBroken > 0 then
            local wheelscount = exports.ox_inventory:Search('count', Config.ItemNames['vehiclewheel'])
            if wheelscount < totalWheelsBroken then
                return lib.notify({
                    title       =  Config.Locales['vehiclerepair'],
                    description =  Config.Locales['needvehiclewheel'] ..totalWheelsBroken,
                    type        = 'error'
                })
            else
                for i = 1, totalWheelsBroken do
                    lib.callback.await('mira_mechanic:removevehiclewheel')
                end
            end
        end

        local fuelLevel = Entity(vehicle).state.fuel
        if lib.progressBar({
            duration     = Config.RepairTime,
            label        = Config.Locales['progress-repair'],
            useWhileDead = false,
            canCancel    = true,
            anim         = { scenario = 'PROP_HUMAN_BUM_BIN' },
        }) then

            SetVehicleFixed(vehicle)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            ClearPedTasks(playerPed)

            if fuelLevel then
                SetVehicleFuelLevel(vehicle, fuelLevel)
                Entity(vehicle).state:set('fuel', fuelLevel, true)
            end
            SetVehicleEngineOn(vehicle, engineStatus, true, true)
            lib.notify({
                title       =  Config.Locales['vehiclerepair'],
                description =  Config.Locales['success'],
                type        = 'success'
            })
        end
    else
        lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['novehicles'],
            type        = 'error'
        })
    end
end

RegisterNetEvent('mira_mechanic:RepairVehicle', function()
    local playerPed = cache.ped
    local coords   = GetEntityCoords(playerPed)
    local playerData = ESX.PlayerData
    local jobName  = playerData.job.name

    local canRepair = false
    local isInMotorworks = false

    if not dilny[jobName] then
        return lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['norepairhere'],
            type        = 'error'
        })
    end

    for k, v in pairs(dilny[jobName]) do
        if #(coords - v) < 100 then
            canRepair = true
            isInMotorworks = true
            break
        end
    end

    if not canRepair then
        for k, v in pairs(GetGamePool('CVehicle')) do
            if #(GetEntityCoords(v) - coords) < 30 then
                if mechanicveh[GetEntityModel(v)] then
                    canRepair = true
                    break
                end
            end
        end
    end

    if canRepair then
        repairVehicle()
    else
        lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['norepairhere'],
            type        = 'error'
        })
    end
end)

function washVehicle()
    local coords = GetEntityCoords(cache.ped or PlayerPedId())
    local vehicle = lib.getClosestVehicle(coords, 6.0, false)
    local distance = #(coords - GetEntityCoords(vehicle))

    if cache.vehicle then
        return lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['outvehicle'],
            type        = 'error'
        })
    end

    local count = exports.ox_inventory:Search('count', Config.ItemNames['sponge'])
    if count == 0 then
        return lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['needsponge'],
            type        = 'error'
        })
    end

    if DoesEntityExist(vehicle) and distance < 6 then
        if lib.progressBar({
            duration     = Config.WashTime,
            label        = Config.Locales['progress-wash'],
            useWhileDead = false,
            canCancel    = true,
            anim         = { scenario = 'WORLD_HUMAN_MAID_CLEAN' },
        }) then
            SetVehicleDirtLevel(vehicle, 0.0)
            ClearPedTasks(playerPed)
        end
    else
        lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['novehicles'],
            type        = 'error'
        })
    end
end

RegisterNetEvent('mira_mechanic:WashVehicle', function()
    local playerPed = cache.ped
    local coords   = GetEntityCoords(playerPed)
    local playerData = ESX.PlayerData
    local jobName  = playerData.job.name

    local canRepair = false

    if not dilny[jobName] then
        return lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['cannotwash'],
            type        = 'error'
        })
    end

    for k, v in pairs(dilny[jobName]) do
        if #(coords - v) < 100 then
            canRepair = true
            break
        end
    end

    if canRepair then
        washVehicle()
    else
        lib.notify({
            title       =  Config.Locales['vehiclerepair'],
            description =  Config.Locales['nowashhere'],
            type        = 'error'
        })
    end
end)
