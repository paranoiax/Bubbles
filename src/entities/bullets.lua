bullets = {}

function bullets:draw()
	love.graphics.setColor(255,150,0)
	for i,v in ipairs(bullets) do
		love.graphics.circle("fill",v.x,v.y,4)
	end
end

function bullets:update(dt)
	for i,v in ipairs(bullets) do
		local px,py = player.body:getX(),player.body:getY()
		v.x = v.x + v.xspeed * dt
		v.y = v.y + v.yspeed * dt
		if v.x < 0 or v.x > love.graphics.getWidth() or v.y < 0 or v.y > love.graphics.getHeight() then
			table.remove(bullets, i)
		end
		if distanceFrom(v.x,v.y,px,py) > weapon.range+math.random(-weapon.recoil,weapon.recoil) then
			table.remove(bullets, i)
		end
	end
end

function bullets:spawn()
	local x,y = love.mouse.getPosition()
	for i=1, weapon.shots do
		local v = {}
		v.x,v.y = player.body:getX()+math.random(-weapon.recoil,weapon.recoil),player.body:getY()+math.random(-weapon.recoil,weapon.recoil)
		local angle = math.atan2(y-v.y+math.random(-weapon.recoil,weapon.recoil),x-v.x+math.random(-weapon.recoil,weapon.recoil))
		v.xspeed = math.cos(angle) * weapon.speed
		v.yspeed = math.sin(angle) * weapon.speed
		table.insert(bullets, v)
	end
end