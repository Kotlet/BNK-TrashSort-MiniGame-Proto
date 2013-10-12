------------------------------------------------------------------------------
--CONFIG

Gamestate = require("gamestate");

menu 			= {}
game_walking 	= {}
game_dnd 		= {}
status 			= {}

love.filesystem.load("toolbox.lua")();
love.filesystem.load("status.lua")();
love.filesystem.load("menu.lua")();
love.filesystem.load("GameObject.lua")();
love.filesystem.load("game_walking.lua")();
love.filesystem.load("game_dnd.lua")();

------------------------------------------------------------------------------
--LOVE

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end