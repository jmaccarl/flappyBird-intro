debug = true

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

lostGame = false
flappyBird = {x = 250, y = 300, speed = 150, img = nil}

function love.load(arg)
	flappyBird.img = love.graphics.newImage('assets/flappy_bird.png')

end


function love.update(dt)
	-- Exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('up', 'w') then
		flappyBird.speed = 150
	end

	flappyBird.y = flappyBird.y - (flappyBird.speed*dt)

	flappyBird.speed = flappyBird.speed - 10

	if flappyBird.y > 750 or flappyBird.y < 0 then
		lostGame = true
	end

end


function love.draw(dt)
	if not lostGame then
    	love.graphics.draw(flappyBird.img, flappyBird.x, flappyBird.y, math.rad(0), .2, .2)
    end

    if lostGame then
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.print("You lost!", 200, 300, 0, 3, 3)
	end
end