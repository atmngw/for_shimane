require File.dirname(__FILE__)  + '/character'
require 'D:\ruby_camp_2010\src\project\exe\scenes/game'

class Player < Character
  attr_accessor :y, :x, :s
  attr_accessor :v
  attr_reader :shts
  def initialize (x, y, image, a)
    super
      @shts = []
      @v = 6
      @s = 8
  end 

  def shoot
    if @shts.length < 4 then
       Game.gun
       @shts << Shoot.new(@x, @y, @s)
    end
  end

  def move ####
    @x += Input.x * @v
    @y += Input.y * @v
    if @x < -30 then
      @x = -30
    elsif @x > (Window.width - 40) then
      @x = (Window.width - 40)
    end 
    if @y < 10 then
      @y = 10
    elsif @y > (Window.height - 40) then
      @y = (Window.height - 40)
    end

    @shts.each do |sht|
      sht.move
    end
    super
  end #### move

  def check_shts ####
    @shts.delete_if do |sht|
      sht.y < -15
    end
  end ####

  def draw ####
    super
    @shts.each do |sht|
       sht.draw
    end
  end ####

  def accel
    @s += 2
  end

  def boost
    @v += 1
  end

  def shot(obj)
  end

  def hit(obj)
  end
end
