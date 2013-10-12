------------------------------------------------------------------------------
--GAME

local animate = function(go)
    local objectAnimation = Anim(5.7);
    objectAnimation.transY = height/2 - object.y;
    objectAnimation.interp = interpolator_deaccelerate;
    go:addAnim(objectAnimation);
    objectAnimation:start();

    local oax = Anim(5.7);
    oax.transX = width/2 - object.x;
    oax.interp = interpolator_accelerate;
    object:addAnim(oax);
    oax:start();

    local objectAnimationRotation = Anim(5.7);
    objectAnimationRotation.rotation = -20.0 * math.pi;
    objectAnimationRotation.interp = interpolator_deaccelerate;
    go:addAnim(objectAnimationRotation);
    objectAnimationRotation:start();

    local oasx = Anim(5.7);
    oasx.scaleX = (width / object.image:getWidth())-object.scalex;
    oasx.interp = interpolator_accelerate;
    go:addAnim(oasx);
    oasx:start();

    local oasy = Anim(5.7);
    oasy.scaleY = (height / object.image:getHeight())-object.scaley;
    oasy.interp = interpolator_accelerate;
    go:addAnim(oasy);
    oasy:start();
end

function game_walking:enter()
    object              = GameObject("TrashCan_generic.png");
    time                = 0;
    deltaUpdate         = 0.3;
    width               = love.graphics.getWidth();
    height              = love.graphics.getHeight();
    object.color        = RGBA(255,0,0);
end

function game_walking:keypressed(key, code)
    if key == KEY_ACTION then
        animate(object);
    end
end

function game_walking:update(dt)
    object:update(dt);
end

function game_walking:draw()
    object:draw();
end

function  game_walking:keyreleased( key, code )
    if key == KEY_PAUSE then
        Gamestate.push(status)
    end
    if key == KEY_BACK then
        Gamestate.pop()
    end
end