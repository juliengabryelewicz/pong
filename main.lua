push = require 'push'

Class = require 'class'

require 'StateMachine'

require 'states/BaseState'
require 'states/StartState'
require 'states/ServeState'
require 'states/PlayState'
require 'states/DoneState'

require 'Player'

require 'Ball'

WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 253

PLAYER_SPEED = 200
SCORE_WIN = 5

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('TouchPong')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    player1 = Player(10, 30, 5, 20)
    player2 = Player(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    player1Score = 0
    player2Score = 0

    servingPlayer = 1

    winningPlayer = 0

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['serve'] = function() return ServeState() end,
        ['play'] = function() return PlayState() end,
        ['done'] = function() return DoneState() end,
    }
    gStateMachine:change('start')

    -- initialize input table
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)

    if love.keyboard.isDown('w') then
        player1.dy = -PLAYER_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PLAYER_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PLAYER_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PLAYER_SPEED
    else
        player2.dy = 0
    end

    player1:update(dt)
    player2:update(dt)

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    displayScore()
    
    player1:render()
    player2:render()
    ball:render()
    gStateMachine:render()

    push:finish()
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end