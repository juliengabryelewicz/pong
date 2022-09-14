PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:update(dt)
    if ball:collides(player1) then
        ball.dx = -ball.dx * 1.03
        ball.x = player1.x + 5

        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end

    end
    if ball:collides(player2) then
        ball.dx = -ball.dx * 1.03
        ball.x = player2.x - 4

        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end

    end

    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
    end

    if ball.y >= VIRTUAL_HEIGHT - 4 then
        ball.y = VIRTUAL_HEIGHT - 4
        ball.dy = -ball.dy
    end

    if ball.x < 0 then
        servingPlayer = 1
        player2Score = player2Score + 1

        if player2Score == SCORE_WIN then
            winningPlayer = 2
            gStateMachine:change('done')
        else
            gStateMachine:change('serve')
            ball:reset()
        end
    end

    if ball.x > VIRTUAL_WIDTH then
        servingPlayer = 2
        player1Score = player1Score + 1

        if player1Score == SCORE_WIN then
            winningPlayer = 1
            gStateMachine:change('done')
        else
            gStateMachine:change('serve')
            ball:reset()
        end
    end

    ball:update(dt)
end

function PlayState:render()

end
