WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 720

function love.load()
    love.window.setTitle("Pong")

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false
    })
end

function love.draw()
    love.graphics.printf("Hola, Lua!", 0, WINDOW_HEIGHT / 2 - 6, WINDOW_WIDTH, "center")
end
