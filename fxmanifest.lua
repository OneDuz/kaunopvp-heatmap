fx_version 'cerulean'
game 'gta5'

lua54 "yes"
author "onecodes"
version "1.0.0"
description 'Simple heat map for zones'



server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua',
}

client_scripts {
    'config.lua',
    'client.lua',
}

shared_script '@ox_lib/init.lua'
