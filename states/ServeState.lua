ServeState = Class{__includes = BaseState}

-- takes 1 second to count down each time
COUNTDOWN_TIME = 0.75

function ServeState:init()
    self.count = 3
    self.timer = 0

end

function ServeState:update(dt)
    self.timer = self.timer + dt

    ball.dy = math.random(-50, 50)
    if servingPlayer == 1 then
        ball.dx = math.random(140, 200)
    else
        ball.dx = -math.random(140, 200)
    end

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function ServeState:render()
    love.graphics.setFont(scoreFont)
    love.graphics.printf(tostring(self.count), 0, 20, VIRTUAL_WIDTH, 'center')
end