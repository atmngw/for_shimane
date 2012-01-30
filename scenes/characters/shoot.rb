require File.dirname(__FILE__)  + '/character'

class Shoot
  attr_reader :x, :y
  attr_accessor :collision
  attr_accessor :speed

  @@image = Image.load("images/bow.png")
  @@image.setColorKey(@@image[0,0])

  def initialize (x, y, v)
    @x = x + 13
    @y = y
    @collision = CollisionBox.new(self, 0, 0, @@image.width - 1, @@image.height - 1)
    @collision.set(@x, @y)
    @speed = v
  end

  def move
    @y -= @speed
    @collision.set(@x, @y)
  end

  def draw
    Window.draw(@x, @y, @@image)
  end

end
