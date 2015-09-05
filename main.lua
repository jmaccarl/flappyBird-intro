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

function drawPillar()
	love.graphics.rectangle('fill', pillar.x, 0, 50, pillar.y)
	love.graphics.rectangle('fill', pillar.x, pillar.y + 200, 50, 800)
end


lostGame = false
flappyBird = {x = 250, y = 300, speed = 150, img = nil}
pillar = {x = 600, y = 400}
score = 0

function love.load(arg)
	flappyBird.img = love.graphics.newImage('assets/flappy_bird.png')
	love.graphics.setBackgroundColor(0, 0, 200)

end


function love.update(dt)
	-- Exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown(' ') and lostGame then
		love.graphics.setBackgroundColor(0, 0, 200)
		lostGame = false
		flappyBird.x = 250
		flappyBird.y = 300
		flappyBird.speed = 150
		pillar = {x = 600, y = 400}
		score = 0
	end

	if love.keyboard.isDown('up', 'w') then
		flappyBird.speed = flappyBird.speed + 50 + score
	end

	if flappyBird.y > 750 or flappyBird.y < 0 then
		lostGame = true
	end

	if CheckCollision(pillar.x, 0, 50, pillar.y, flappyBird.x, flappyBird.y, flappyBird.img:getWidth()*.2, flappyBird.img:getHeight()*.2) then
		lostGame = true
	end

	if CheckCollision(pillar.x, pillar.y + 200, 50, 800, flappyBird.x, flappyBird.y, flappyBird.img:getWidth()*.2, flappyBird.img:getHeight()*.2) then
		lostGame = true
	end

    if not lostGame then
		pillar.x = pillar.x - 5;
	    flappyBird.y = flappyBird.y - (flappyBird.speed*dt)

	   flappyBird.speed = flappyBird.speed - 20 - score
	end 

	if pillar.x <= 0 then
		pillar.x = 600
		pillar.y = 200 + love.math.random(400)
	end

	if pillar.x == 250 then
		score = score + 1
	end

end


function love.draw(dt)
	if not lostGame then
    	love.graphics.draw(flappyBird.img, flappyBird.x, flappyBird.y, math.rad(0), .2, .2)
    	drawPillar()
        love.graphics.print("Score: " .. tostring(score), 0, 0, 0, 2, 2)
    end

    if lostGame then
    	love.graphics.setBackgroundColor(200, 0, 0)
		love.graphics.print("Splat! Score: " .. tostring(score), 175, 300, 0, 3, 3)
		love.graphics.print("\nPress spacebar to retry", 175, 350, 0, 2, 2)
	end

end