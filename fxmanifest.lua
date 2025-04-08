game 'gta5'
fx_version 'cerulean'
lua54 'yes'
author 'mira0423'
description 'Vehicle Repair'
version '1.00'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'ox_inventory',
    'ox_target',
    'ox_lib'
}
