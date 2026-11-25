-- ventana principal
WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 720

-- para la resolucion
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- velocidad de los jugadores
PADDLE_SPEED = 200

-- libreria externa
push = require 'push'

function love.load()
    -- evitar blur
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- random para el movimiento de la pelota
    math.randomseed(os.time())

    -- declaracion de las fuentes
    largeFont = love.graphics.newFont('font.otf', 32)
    smallFont = love.graphics.newFont('font.otf', 8)

    -- score
    player1Score = 0
    player2Score = 0

    -- pos inicial player 1
    player1Y = VIRTUAL_HEIGHT / 2 - 8
    -- pos inicial player 2
    player2Y = VIRTUAL_HEIGHT / 2 - 8

    -- velocidad y pos inicial para la bola
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- gestionar la velocidad de la bola
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    -- setup basico de graficos
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
        highdpi = false
    })

    gameState = 'start'
end

-- al pulsar escape el programa finaliza
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
        -- empezar partida al pulsar enter
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            -- bola al centro al iniciar
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

-- funcion que se actualiza con la pantalla
function love.update(dt)
    -- movimiento jugador 1 (w / s)
    -- math.max y math.min hacen las colisiones con los bordes
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- movimiento jugador 1 (flecha arriba / flecha abajo)
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    -- si se esta ejecutando actualizar la posicion de la bola
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

-- mostrar por pantalla
function love.draw()
    push:start()

    -- color de fondo
    love.graphics.clear(127 / 255, 0 / 255, 255 / 255, 1) -- rgba

    -- contador de puntuacion de jugadores
    love.graphics.setFont(largeFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 92)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 12, VIRTUAL_HEIGHT / 2 - 76, 24, 4)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 92)

    -- paddle 1
    -- posX, posY, Width, Height
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- paddle 2
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, player2Y, 5, 20)

    -- ball
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    push:finish()
end
