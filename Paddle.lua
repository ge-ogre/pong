Paddle = Class{}

function Paddle:init(x, y, wd, ht)
	self.x = x
	self.y = y
	self.wd = wd
	self.ht = ht
	self.dy = 0
end

function Paddle:update(dt)
	if self.dy < 0 then
		self.y = math.max(0, self.y + self.dy * dt)
	else
		self.y = math.min(VIRTUAL_HEIGHT - self.ht, self.y + self.dy * dt)
	end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.wd, self.ht)
end