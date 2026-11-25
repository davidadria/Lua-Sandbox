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

    -- declaracion de las fuentes
    largeFont = love.graphics.newFont('font.otf', 32)
    smallFont = love.graphics.newFont('font.otf', 8)

    -- score
    player1Score = 0
    player2Score = 0

    -- initial pos player 1
    player1X = 0
    player1Y = 0

    -- initial pos player 2
    player2X = 10
    player2Y = VIRTUAL_HEIGHT - 30

    -- setup basico de graficos
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
        highdpi = false
    })
end

-- al pulsar escape el programa finaliza
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

-- funcion que se actualiza con la pantalla
function love.update(dt)
    -- movimiento jugador 1 (w / s)
    if love.keyboard.isDown('w') then
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- movimiento jugador 1 (flecha arriba / flecha abajo)
    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
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
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:finish()
end
