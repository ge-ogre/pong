push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
	love.graphics.setDefaultFilter('nearest','nearest')

	love.window.setTitle('dick')

	math.randomseed(os.time())

	smallFont = love.graphics.newFont('font.ttf', 8)
	love.graphics.setFont(smallFont)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    p1score = 0
    p2score = 0

    p1 = Paddle(10, 30, 5, 20)
    p2 = Paddle(VIRTUAL_WIDTH-10, VIRTUAL_HEIGHT-50, 5, 20)

    ball = Ball(VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT/2-2, 4, 4)

    gameState = 'start'

end

function love.update(dt)
	-- collides with a paddle
	if ball:collides(p1) then
		ball.dx = -ball.dx * 1.03
		ball.x = p1.x + 5
		if ball.dy < 0 then 
			ball.dy = -math.random(10, 150)
		else
			ball.dy = math.random(10, 150)
		end
	end
	if ball:collides(p2) then
		ball.dx = -ball.dx * 1.03
		ball.x = p2.x - 4
		if ball.dy < 0 then 
			ball.dy = -math.random(10, 150)
		else
			ball.dy = math.random(10, 150)
		end
	end

	-- collides with the top or bottom of the screen
	if ball.y <= 0 then
		ball.y = 0
		ball.dy = -ball.dy
	end
	if ball.y >= VIRTUAL_HEIGHT-4 then
		ball.y = VIRTUAL_HEIGHT-4
		ball.dy = -ball.dy
	end
 
	--movement
    if love.keyboard.isDown('w') then
        p1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        p1.dy = PADDLE_SPEED
    else
        p1.dy = 0
    end
    if love.keyboard.isDown('up') then
        p2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        p2.dy = PADDLE_SPEED
    else
        p2.dy = 0
    end

    --update 
	if gameState == 'play' then
		ball:update(dt)
	end
	p1:update(dt)
	p2:update(dt)
end

function displayFPS()	
	love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	elseif key == 'enter' or key == 'space' then
		if gameState == 'start' then
			gameState = 'play'
		else
			gameState = 'start'

			ball:reset()
		end
	end 
end		


function love.draw()
	push:apply('start')
	love.graphics.clear(40/255, 45/255, 52/255, 255/255)
	love.graphics.printf('what da dog doin', 0, 20, VIRTUAL_WIDTH, 'center')

	p1:render()
    p2:render()

	ball:render()

	--slove.graphics.printf(gameState, 5, 5, VIRTUAL_WIDTH, 'left')

	displayFPS()

	push:apply('end')
end
