fx_version 'cerulean'
game 'gta5'

description 'BABA HUD'
author 'Kortex'
version '1.0.0'

ui_page "ui/index.html"

shared_script '@es_extended/imports.lua'

files {
    "ui/*.*",
	"ui/assets/*.*",
	"ui/assets/css/*.*",
	"ui/assets/img/*.*",
	"ui/assets/js/*.*",
}

client_scripts {
	'client.lua',
}
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
} 