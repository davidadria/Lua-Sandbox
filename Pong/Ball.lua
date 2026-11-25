Ball = Class {}

-- inicializa la clase
function Ball:init(x, y, width, height)
    -- constructor
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- gestionar la velocidad
    self.dy = math.random(2) == 1 and 180 or -180
    self.dx = math.random(-40, 40)
end

-- centrar en la pantalla
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and 180 or -180
    self.dx = math.random(-40, 40)
end

-- actualizar la posicion
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
