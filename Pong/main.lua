-- ventana principal
WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 720

-- para la resolucion
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- velocidad de los jugadores
PADDLE_SPEED = 200

-- librerias externas
push = require 'push'
Class = require 'class'

-- objetos
require 'Paddle'
require 'Ball'

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

    -- objetos de clase
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50, 5, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

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
            -- mover al centro y reiniciar el random de velocidad
            ball:reset()
        end
    end
end

-- funcion que se actualiza con la pantalla
function love.update(dt)
    -- pos inicial al comenzar
    player1.dy = 0
    player2.dy = 0

    -- movimiento jugador 1 (w / s)
    -- math.max y math.min hacen las colisiones con los bordes
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    end

    -- movimiento jugador 2 (flecha arriba / flecha abajo)
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    end

    -- si se esta ejecutando actualizar la posicion de la bola
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
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
    player1:render()

    -- paddle 2
    player2:render()

    -- bola
    ball:render()

    push:finish()
end
