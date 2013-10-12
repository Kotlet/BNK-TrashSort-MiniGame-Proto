------------------------------------------------------------------------------
--DECLARATIONS

Anim = {}
GameObject = {}

------------------------------------------------------------------------------
--INTERPOLATORS

interpolator_linear = function(x)
	return x;
end

interpolator_deaccelerate = function(x)
	return (1.0 - (1.0 - x) * (1.0 - x)); -- decelerate
end

interpolator_accelerate = function(x)
	return x * x;
end

interpolator_random = function(x)
	return math.random();
end

------------------------------------------------------------------------------
--ANIMATION

Anim.__index = Anim;

setmetatable(Anim, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
});

function Anim.new(dur)
  local self = setmetatable({}, Anim);
  self.started 	= false;
  self.finished = false;
  self.duration = dur;
  self.elapsed 	= 0;
  self.delay 	= 0;
  self.rotation = 0;
  self.scaleX 	= 0;
  self.scaleY 	= 0;
  self.transX 	= 0;
  self.transY 	= 0;
  self.interp 	= interpolator_linear;
  self.color		= nil;
  self.startColor 	= nil;
  self.deltaColor   = nil;
  return self
end

function Anim:start()
	self.started = true;
	self.delta_color = {
		self.startColor[1] - self.color[1];
		self.startColor[2] - self.color[2];
		self.startColor[3] - self.color[3];
		self.startColor[4] - self.color[4];
	}
end

function Anim:update (dt, go)
	if not self.started then 
		return;
	end
	local prev_elapsed = self.elapsed;
	self.elapsed = self.elapsed + dt;
	if self.elapsed > self.duration then
		dt = dt - (self.elapsed - self.duration);
		self.elapsed 	= self.duration;
		self.started 	= false;
		self.finished 	= true;
	end

	local t1 = prev_elapsed / self.duration;
	local t2 = self.elapsed / self.duration;
	local ti = self.interp(t2) - self.interp(t1);

	go.x = go.x + ti * self.transX;
	go.y = go.y + ti * self.transY;
	go.rotation = go.rotation + ti * self.rotation;
	go.scalex = go.scalex + ti * self.scaleX;
	go.scaley = go.scaley + ti * self.scaleY;
	
	go.color = {
		go.color[1] - delta_color[1] * ti;
		go.color[2] - delta_color[2] * ti;
		go.color[3] - delta_color[3] * ti;
		go.color[4] - delta_color[4] * ti;
	}
end

function Anim:attachTo (go)
	if self.color == nil then
		self.color = go.color;
	end
	if self.startColor == nil then
		self.startColor = go.color;
	end
end

------------------------------------------------------------------------------
--GAME OBJECT

GameObject.__index = GameObject;

setmetatable(GameObject, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
});

function GameObject.new(imageString)
	local self = setmetatable({}, GameObject);
	if(imageString ~= nil) then
		self.image 	= love.graphics.newImage(imageString);
	end
	self.animations = {};
	self.x 			= 0;
	self.y 			= 0;
	self.rotation 	= 0;
	self.scalex 	= 1.0;
	self.scaley 	= 1.0;
	self.color 		= RGBA(255,255,255);
  return self
end

function GameObject:draw()
	local hadColor = {love.graphics.getColor()};
	love.graphics.setColor(self.color);
	love.graphics.draw(self.image, 
		self.x, self.y, 
		self.rotation, 
		self.scalex, self.scaley, 
		self.image:getWidth()/2 , 
		self.image:getHeight()/2);
	love.graphics.setColor(hadColor);
end

function GameObject:addAnim(animation)
	animation:attachTo(self);
	table.insert(self.animations,1,animation);
end

function GameObject:update (dt)
	for key, animation in pairs(self.animations) do
		animation:update(dt, self);
	end
	-- update with animations
end
