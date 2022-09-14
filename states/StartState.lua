StartState = Class{__includes = BaseState}

function StartState:init()
    -- nothing
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('serve')
    end
end

function StartState:render()
    love.graphics.setFont(smallFont)
    love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
end