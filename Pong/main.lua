WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    largeFont = love.graphics.newFont('font.otf', 32)
    smallFont = love.graphics.newFont('font.otf', 8)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
        highdpi = false
    })
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    push:start()

    love.graphics.clear(127 / 255, 0 / 255, 255 / 255, 1) -- rgba
    love.graphics.setFont(largeFont)
    love.graphics.printf('Hola, Lua!', 0, VIRTUAL_HEIGHT / 2 - 4, VIRTUAL_WIDTH, 'center')

    push:finish()
end
