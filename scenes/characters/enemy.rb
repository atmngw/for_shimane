require File.dirname(__FILE__)  + '/character'
require 'D:\ruby_camp_2010\src\project\exe\scenes/game'


class Enemy < Character
  attr_accessor :cnt
  attr_accessor :main
  attr_reader   :life
  attr_reader   :type
  attr_reader   :x, :y

  def initialize (x, y, image, a)
    super
    @cnt  = 0
    @life = 0
    @main = 0
    @type = a
    @time = 0
    @v    = 2
    if @type == 1
      @life = 60
    elsif @type >= 10
      @v = 4
      @life = 3
    end

 
  end

  def move
    if main == 0 then
      @time += 1
      if @type == 1           # おろち
        @x += rand(3) - 1
        if @y < 0 then
          @y +=1
        elsif @time % 10 == 0
          @y += 1
        end
      elsif @type == 9  || @type == 7 then   # プレイヤくん
        @x += rand(3) - 1
        @y += rand(3) - 1
        @y += @v
        @x += 3 * Math.sin(@time / 15 )
      elsif @type == 8 then   # エネミーくん
        @x += rand(3) - 1
        @y += rand(3) 
        @y += 2 * Math.cos(@time / 15)
        @x += 3 * Math.sin(@time / 15 )
      elsif @type <= 10 then  # キングおばけ ノーマル
        @x += rand(3) - 1
        @y += rand(3) - 1
        @y += @v
      else                    # おろちの周りのキングおばけ
        @x += rand(3) - 1
        @y += rand(3) - 1
        @x += Math.sin(@type) * 3
        @y += Math.cos(@type) * 3
      end
      super
    elsif main == 1 then
        @x += rand(3) - 1
        @y += rand(3) - 1
    end
  end

  def dead
    if main == 1 && cnt == 70 then
      update_image("images/boss4.png")
    end
    if main == 1 && cnt == 90 then
      update_image("images/boss5.png")
    end
    if main == 1 && cnt == 110 then
      update_image("images/boss6.png")
    end
    if main == 1 && cnt == 130 then
      update_image("images/boss7.png")
    end
  end

  def shot(obj)
  end

  def hit(obj)
    @life += -1
    if @type == 1      # おろちの判定
      if life == 20 then
        Game.ang
        update_image("images/boss1.png")
      end
      if life == 8 then
        Game.ang
        update_image("images/boss2.png")
      end
      if life == 0
        Game.boss
        update_image("images/boss3.png")
        @main = 1
        Game.win
      end
    end
    if @type == 9   # しまねっこの判定
      Game.bom
      update_image("images/nekko2.png")
      @main = 1
      Game.point
    end
    if @type == 7   # プレイヤくんの判定
      Game.bom
      update_image("images/player-2.PNG")
      @main = 1
      Game.point
    end
    if @type == 8   # エネミーくんの判定
      Game.bom
      update_image("images/enemy-2.PNG")
      @main = 1
      Game.point
    end
    if @type >= 10  # キングオバケの判定
      if life == 0 then
        Game.bom
        update_image("images/death2.png")
        @main = 1
        Game.point2
      end
    end
    if @type == 0   # オバケ（雑魚）の判定
      Game.bom
      update_image("images/death.png")
      @main = 1
      Game.point
    end
  end

end
