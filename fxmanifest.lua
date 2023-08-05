fx_version 'cerulean'
game 'gta5'

description 'setblip'
author 'Mark'
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
	'server.lua'
} 
