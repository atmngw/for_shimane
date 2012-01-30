require File.dirname(__FILE__)  + '/characters/player'
require File.dirname(__FILE__)  + '/characters/enemy'
require File.dirname(__FILE__)  + '/characters/shoot'

class Game
  include Math
  attr_accessor :enemies

  @@sounds = {:player => Sound.new("sounds/peterwolf.mid"),
              :boss   => Sound.new("sounds/boss.wav"),
              :susa   => Sound.new("sounds/susanoh.wav"),
              :pop    => Sound.new("sounds/pop_boss.wav"),
              :ang    => Sound.new("sounds/angry.wav"),
              :gun    => Sound.new("sounds/shot.wav"),
              :speed  => Sound.new("sounds/speed.wav"),
              :bom    => Sound.new("sounds/muchi2.wav")}

  @@point = 0
  @@vonus = 0

  def initialize
    @game_image = Image.load("images/back.PNG")
    @ex   = 350                 # 自機の初期の出現位置
    @ey   = 100
    @cnt  = 0                   # ゲーム開始から時間がどのくらいたったか
    @flag = 0                   # ボスが出現したか
    @clear = 0
    @player = Player.new(400, 500, "images/susa.png",0)
    @enemies = Array.new
    @enemies << Enemy.new(250, 170, "images/oba.png",0)
    @font = Font.new(32)
    @image
    @chk = 0
  end

  def play  #### game の main 関数
    if Input.keyPush?(K_SPACE) then
      if @clear == 0 then
        @player.shoot
      end
    end
    @cnt += 1
    @player.move
    self.enemies.each do |char|
      char.move
      char.dead
    end

    check_collision            # 敵と自機の衝突チェック
    check_attack               # 敵と矢の衝突チェック
    check_death                # 敵が死んだかどうか
    check_clear                # クリア条件を満たしたか
    encount                    # 敵の出現

    @player.check_shts         # 矢が範囲から外れたか
    if @cnt == 0 then
      update(@image)
    end
    if @cnt == 200then
    @image = "images/back2.PNG"
      update(@image)
    end
    if @cnt == 400then
    @image = "images/back3.PNG"
      update(@image)
    end
    if @cnt == 600then
    @image = "images/back4.PNG"
      update(@image)
    end
    if @cnt == 800then
    @image = "images/back5.PNG"
      update(@image)
    end
    if @cnt == 1000then
    @image = "images/back6.PNG"
      update(@image)
    end
    if @cnt == 1200then
    @image = "images/back7.PNG"
      update(@image)
    end
    if @cnt == 1400then
    @image = "images/back8.PNG"
      update(@image)
    end
    draw
    self.enemies.each do |char|
      char.draw
    end
    @player.draw
    draw_point
  end  #### play

  def draw
    Window.draw(0, 0, @game_image)
  end

  def encount#### 敵の出現
    @@vonus = 1000000 - (@cnt * 100)
    if @clear == 0 then
      if @cnt % 80 == 0 then
        @enemies << Enemy.new(rand(Window.width), 0, "images/oba.png",0)
      end
      if (@cnt > 300 && (@cnt % 57 == 0))
        @enemies << Enemy.new(rand(Window.width), 0, "images/oba.png",0)
      end
      if @cnt == 800
        @@sounds[:pop].setVolume(255)
        @@sounds[:pop].play
        @enemies << Enemy.new(300, -200, "images/boss0.png",1)
        @flag = 1
      end

      if @cnt > 400 && rand(240) % 240 == 0 then
        @enemies << Enemy.new(rand(Window.width), 0, "images/oba2.png",10)
      end 
      if @cnt > 200 && rand(240) % 240 == 0 then
        @enemies << Enemy.new(rand(Window.width), 0, "images/nekko.png",9)
      end 
      if @cnt > 200 && rand(500) % 500 == 0 then
        @enemies << Enemy.new(rand(Window.width), 0, "images/player.png",7)
      end 
      if @cnt > 400 && rand(240) % 240 == 0 then
        @enemies << Enemy.new(rand(Window.width), 0, "images/enemy.png",8)
      end 
      if @cnt > 700 && rand(240) % 240 == 0 then
        @enemies << Enemy.new(rand(Window.width), 0, "images/oba2.png",10)
      end 

      if @flag == 1 then
        if @cnt % 200 == 0 then
          @enemies.each do |e|
            if e.type == 1then
              @ex = e.x + 80
              @ey = e.y + 50
            end
          end
          @enemies << Enemy.new(@ex + (130 * sin(30)) , @ey + (130 * cos(30)),  "images/oba2.png",30 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(60)) , @ey + (130 * cos(60)),  "images/oba2.png",60 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(90)) , @ey + (130 * cos(90)),  "images/oba2.png",90 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(120)), @ey + (130 * cos(120)), "images/oba2.png",120 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(150)), @ey + (130 * cos(150)), "images/oba2.png",150 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(180)), @ey + (130 * cos(180)), "images/oba2.png",180 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(210)), @ey + (130 * cos(210)), "images/oba2.png",210 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(240)), @ey + (130 * cos(240)), "images/oba2.png",240 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(270)), @ey + (130 * cos(270)), "images/oba2.png",270 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(300)), @ey + (130 * cos(300)), "images/oba2.png",300 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(330)), @ey + (130 * cos(330)), "images/oba2.png",330 + @cnt)
          @enemies << Enemy.new(@ex + (130 * sin(360)), @ey + (130 * cos(360)), "images/oba2.png",360 + @cnt)
        end
      end
    end
  end #### encount


  def check_clear #### 
    @enemies.each do |e|
      if e.main == 1 && e.type == 1 then
         @clear = 1
      end
    end
    if @clear == 1
       @enemies.delete_if do |e|
         e.type != 1
       end
   end
    if Input.keyPush?(K_RETURN)
      Scene.set_current_scene(:ending)
    end
  end  #### check_clear


  def check_attack ####
    @player.shts.delete_if do |sht|
      Collision.check(sht.collision, @enemies.map{|e| e.collision})
    end
  end #### check_attack


#  def check_collision #### 
#    if @clear == 0 then
#    if Collision.check(@player.collision, @enemies.map{|e| e.collision})
#      700000.times do
#       @cnt += 1
#      end
#     Scene.set_current_scene(:gameover)
#       @enemies.clear
#       @cnt  = 0
#       @flag = 0
#        @clear = 0
#        @player.shts.clear
#       @player.x = 400
#       @player.y = 500
#       @@point = 0
#   end
#   end
# end  #### check_collision

  def check_collision #### 改造版
    if @clear == 0 then
      @enemies.each do |e|
        if Collision.check(@player.collision, e.collision) then
          if e.type == 9 || e.main == 0 then
            @player.accel
            @@sounds[:speed].play
          elsif e.type == 7 || e.main == 0 then
            if @chk == 0 then
              @player.boost
              @chk += 1
            end
          else
           @@sounds[:susa].play
          700000.times do
            @cnt += 1
          end
          Scene.set_current_scene(:gameover)
          @enemies.clear
          @cnt  = 0
          @flag = 0
          @clear = 0
          @player.shts.clear
          @player.x = 400
          @player.y = 500
          @player.s = 8
          @player.v = 6
          @@point = 0
          @image = "images/back.PNG"
          end
        end
      end
    end
    @chk = 0
  end #### check_collision 改造版


  def check_death ####
    @enemies.each do |e|
      if e.main == 1 then
        e.cnt += 1
      end
    end
    @enemies.each do |e|
      if e.cnt == 150 && e.type == 1          # おろちがやられるまでの時間
        Scene.set_current_scene(:ending)
        @enemies.clear
        @cnt  = 0
        @flag = 0
        @clear = 0
        @player.shts.clear
        @player.x = 400
        @player.y = 500
        @player.s = 8
        @player.v = 6
        @@point = 0
    @image = "images/back.PNG"
      end
    end
    @enemies.delete_if do |e|
     e.type != 1 && e.cnt == 10
    end
  end #### check_death

  def draw_point
   str = "point " + @@point.to_s
    Window.drawFont(10, 10, str, @font)
  end

  def self.bom #爆撃音
    @@sounds[:bom].play
  end
  def self.boss #爆撃音
    @@sounds[:boss].play
  end
  def self.speed #爆撃音
    @@sounds[:speed].play
  end
  def self.ang #爆撃音
    @@sounds[:ang].play
  end
  def self.gun #爆撃音
    @@sounds[:gun].setVolume(255)
    @@sounds[:gun].play
  end

  def update(image)
    @game_image = Image.load(image)
  end

  def self.point
    @@point += 100
  end

  def self.point2
    @@point += 500
  end

  def self.win
    if @@vonus > 0 then
      @@point += @@vonus
    end
    @@point += 10000
  end
end
