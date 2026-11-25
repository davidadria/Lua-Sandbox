Ball = Class {}

-- inicializa la clase
function Ball:init(x, y, width, height)
    -- constructor
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- gestionar la velocidad
    self.dy = math.random(2) == 1 and 50 or -50   -- se desplaza menos en el eje Y al sacar
    self.dx = math.random(2) == 1 and 160 or -160 -- se mueve mas horizontalmente
end

-- centrar en la pantalla
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and 50 or -50
    self.dx = math.random(2) == 1 and 160 or -160
end

-- actualizar la posicion
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

-- colisiones
function Ball:collides(paddle)
    -- borde izquierdo mas a la derecha que el borde derecho del otro
    if self.x >= paddle.x + paddle.width or paddle.x >= self.x + self.width then
        return false
    end

    -- borde abajo mas alto que el borde del otro
    if self.y >= paddle.y + paddle.height or paddle.y >= self.y + self.height then
        return false
    end

    -- ambas false, se estan solapando
    return true
end
