ground = {}

function ground:init()
	self.body = love.physics.newBody(world,love.graphics:getWidth() / 2,love.graphics:getHeight() - 50,"static")
	self.shape = love.physics.newRectangleShape(love.graphics:getWidth(),100)
	self.fixture = love.physics.newFixture(self.body,self.shape,1)
end
function ground:draw()
	love.graphics.polygon("fill",ground.body:getWorldPoints(ground.shape:getPoints()))
end