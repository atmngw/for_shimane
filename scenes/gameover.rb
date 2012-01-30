class Gameover
  def initialize
    @ending_image = Image.load("images/gameover.bmp")
  end

  def draw
    Window.draw(0, 0, @ending_image)
  end

  def play
    draw
    if Input.keyPush?(K_F5)
      Scene.set_current_scene(:title)
    end
    if Input.keyPush?(K_RETURN)
#      exit
      Scene.set_current_scene(:title)
    end
  end
end
