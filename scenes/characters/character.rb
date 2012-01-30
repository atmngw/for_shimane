class Character
  attr_accessor :collision


  def initialize(x = 400, y = 550, image_file = "images/player.png", a = 0)
    @x, @y = x, y
    @type = 0
    @image = Image.load(image_file)
    @image.setColorKey(@image[0,0])
    @collision = CollisionBox.new(self, 0, 0, @image.width - 7, @image.height - 7)
    @collision.set(@x + 3, @y + 3)
  end
  def move
    @collision.set(@x, @y)
  end

  def draw
    Window.draw(@x, @y, @image)
  end

  def update_image(image_file) 
    @image = Image.load(image_file)    
  end

end
