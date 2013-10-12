------------------------------------------------------------------------------
--MENU

function menu:enter()
	pauseMsg 
		= string.format("Press %s anytime for status/pause screen",
			keyToString(KEY_PAUSE));
	dndMsg 
		= string.format("Press %s to start in drag and drop mode",
			keyToString(KEY_DND));
	walkingMsg 
		= string.format("Press %s to start in walking mode",
			keyToString(KEY_WALKING));

	wholeMsg = string.format("%s\n%s\n%s",
		pauseMsg,dndMsg,walkingMsg);
end

function menu:draw()
	local w = love.graphics.getWidth();
	local h = love.graphics.getHeight();

	love.graphics.setColor(0,255,0);
    love.graphics.printf(
    	"Trash Sort game prototype for B-Game",
    	0, 10, w,"center");

    love.graphics.setColor(0,255,255);
    love.graphics.printf(
    	wholeMsg,
    	0, h/4, w,"center");

    love.graphics.setColor(255,0,0);
    love.graphics.printf(
    	quitMsg,
    	0, h/2, w,"center");
end

function  menu:keyreleased( key, code )
	if key == KEY_PAUSE then
        Gamestate.push(status)
    end
    if key == KEY_BACK then
        love.event.push("quit");
    end
    if key == KEY_DND then
    	Gamestate.push(game_dnd)
    end
    if key == KEY_WALKING then
    	Gamestate.push(game_walking)
    end
end