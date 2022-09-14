DoneState = Class{__includes = BaseState}

function DoneState:init()
    -- nothing
end

function DoneState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        ball:reset()

        player1Score = 0
        player2Score = 0

        if winningPlayer == 1 then
            servingPlayer = 2
        else
            servingPlayer = 1
        end
        gStateMachine:change('serve')
    end
end

function DoneState:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
        0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
end