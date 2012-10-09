function distanceFrom(x1,y1,x2,y2)
	local distance = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
	return math.floor(distance + .5)
end

require 'lib.AnAL'
require 'entities.world'
require 'entities.bullets'
require 'entities.player'
require 'entities.weapon'
require 'entities.ground'

function love.load()

	player:init()
	ground:init()
	
end

function love.update(dt)
	
	world:update(dt)
	player.walkcycle.anim:update(dt)
	player.idle.anim:update(dt)
	player.midair.anim:update(dt)
	player:controls(dt)
	bullets:update(dt)
	
end

function love.draw()

	ground:draw()
	bullets:draw()
	player:draw()
	
	love.graphics.print(#bullets,10,10)
	
end

function love.keypressed(key,unicode)
	if key == "w" then
		player:jump()
	end
end

function love.keyreleased(key,unicode)	
	if key == "d" or key == "a" then
		player:stop()
	end
end

function love.mousepressed(x,y,b)
	if b == "l" then
		bullets:spawn()
	end
end