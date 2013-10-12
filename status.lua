------------------------------------------------------------------------------
--STATUS INIT
status.name		= "STATUS";
status.points 	= 0;

------------------------------------------------------------------------------
--STATUS SCREEN

function status:enter()
	self.keyrelease = globalKeyRelease;
end

function status:draw()
    local w = love.graphics.getWidth();
	local h = love.graphics.getHeight();

	local stat_msg 
		= string.format("PAUSED CURRENT GAME STATE: %s", status.name);
	love.graphics.setColor(0,255,0);
    love.graphics.printf(
    	stat_msg,
    	0, 10, w,"center");

    --[[
    love.graphics.setColor(0,255,255);
    love.graphics.printf(
    	"Press Space anytime for status/pause screen \
    	Press 1 to start in drag and drop mode \
    	Press 2 to start in walking mode ",
    	0, 60, w,"center");
	--]]

    love.graphics.setColor(255,0,0);
    love.graphics.printf(
    	quitMsg,
    	0, 200, w,"center");
end

function  status:keyreleased( key, code )
    if key == 'escape' or key == ' ' then
        Gamestate.pop()
    end
end