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

    love.window.setTitle('Pong')

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

    if ball:collides(player1) then
        -- detectar la colision y revertir el eje X y aumentar un poco la velocidad
        ball.dx = -ball.dx * 1.05
        -- sacar la bola de la paddel usando su ancho real
        ball.x = player1.x + player1.width

        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end
    end

    -- lo mismo de arriba
    if ball:collides(player2) then
        ball.dx = -ball.dx * 1.05
        ball.x = player2.x - ball.width

        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end
    end

    -- detectar colisiones de la bola con los margenes
    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
    end

    if ball.y >= VIRTUAL_HEIGHT - 4 then
        ball.y = VIRTUAL_HEIGHT - 4
        ball.dy = -ball.dy
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
    player1:render()

    -- paddle 2
    player2:render()

    -- bola
    ball:render()

    -- mostrar FPS
    displayFPS()

    push:finish()
end

-- mostrar fps por pantalla
function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end
