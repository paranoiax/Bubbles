player = {
	walkcycle = {},
	idle = {},
	midair = {},
}

function player:init()
	self.body = love.physics.newBody(world,100,100,"dynamic")
	self.shape = love.physics.newCircleShape(25)
	self.fixture = love.physics.newFixture(self.body,self.shape,1)
	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.direction = "right"
end

player.walkcycle.image = love.graphics.newImage("images/walkcycle.png")
player.walkcycle.anim = newAnimation(player.walkcycle.image,50,55,0.08,0)

player.idle.image = love.graphics.newImage("images/idle.png")
player.idle.anim = newAnimation(player.idle.image,50,55,0.3,0)

player.midair.image = love.graphics.newImage("images/midair.png")
player.midair.anim = newAnimation(player.midair.image,50,55,0.08,0)
player.midair.anim:setMode("once")

function player:jump()
	local x,y = player.body:getLinearVelocity(x,y)
	if y == 0 then
		player.body:setGravityScale(3)
		player.body:applyLinearImpulse(0,-500)
	end
end

function player:stop()	
	local x,y = player.body:getLinearVelocity(x,y)
	player.body:setLinearVelocity(x - x / 1.25,y)
end

function player:draw()
	love.graphics.setColor(255,255,255)
	local x,y = self.body:getLinearVelocity(x,y)
	if y < 0 or y > 0 then
		if self.direction == "right" then
			player.midair.anim:draw(player.body:getX(),player.body:getY(),0,1,1,25,25)
		else
			player.midair.anim:draw(player.body:getX(),player.body:getY(),0,-1,1,25,25)
		end
	end
	if x < 0 or x > 0 then
		if y == 0 then
			if self.direction == "right" then
				player.walkcycle.anim:draw(player.body:getX(),player.body:getY(),0,1,1,25,25)
			else
				player.walkcycle.anim:draw(player.body:getX(),player.body:getY(),0,-1,1,25,25)
			end
		end			
	end
	if x == 0 and y == 0 then
		if self.direction == "right" then
			player.idle.anim:draw(player.body:getX(),player.body:getY(),0,1,1,25,25)
		else
			player.idle.anim:draw(player.body:getX(),player.body:getY(),0,-1,1,25,25)
		end
	end
end

function player:controls(dt)
	local x,y = self.body:getLinearVelocity(x,y)
	if y == 0 then
		self.body:setGravityScale(1)
	end
	if love.keyboard.isDown("d") then		
		self.body:setLinearVelocity(18000*dt,y)
		--self.direction = "right"
	end
	if love.keyboard.isDown("a") then		
		self.body:setLinearVelocity(-18000*dt,y)
		--self.direction = "left"
	end
	if love.mouse:getX() < self.body:getX() then
		self.direction = "left"
	elseif love.mouse:getX() > self.body:getX() then
		self.direction = "right"
	end
end