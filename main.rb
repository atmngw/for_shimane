$KCODE = 'sjis'

require 'dxruby'
require "dxrubyex"
require 'scene'

require 'scenes/game'
require 'scenes/title'
require 'scenes/ending'
require 'scenes/gameover'

require 'text'
require 'scroll_text'

Window.caption = "‚¨‚Î‚¯‘å”­¶II@`•œŠˆ‚Ì‚¨‚ë‚¿`"
Window.width   = 800
Window.height  = 600

game     = Game.new
title    = Title.new
ending   = Ending.new
gameover = Gameover.new

Scene.add_scene(title,   :title)
Scene.add_scene(game,    :game)
Scene.add_scene(ending,  :ending)
Scene.add_scene(gameover,:gameover)


Scene.set_current_scene(:title)


Window.loop do
  break if Input.keyPush?(K_ESCAPE)
  Scene.play_scene
end
