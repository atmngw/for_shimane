class Title
  def initialize
    @title_image = Image.load("images/top4.3.bmp")
    str  = "しまねのために\n"
    mes1 = "●あらすじ"
    mes2 = "　出雲大社にオバケがでるようになって、しまねっこちゃんが困っています"
    mes3 = "　矢印とスペースキーですうちゃんを動かして、
  しまねっこちゃんを守って！"
    @describe_text = Array.new
    @describe_text << Text.new(str, 
                              :x => 18, :y => 20,
                              :font_size => 50,
                              :color => [255, 255, 255],  # フォント色を白色に設定
                              :bold => true)
    @describe_text << Text.new(mes1, 
                              :x => 25, :y => 80,
                              :font_size => 10,
                              :color => [255, 255, 255],  # フォント色を白色に設定
                              :bold => true)
    @describe_text << Text.new(mes2, 
                              :x => 25, :y => 95,
                              :font_size => 12,
                              :color => [255, 255, 255],  # フォント色を白色に設定
                              :bold => true)
   @describe_text << Text.new(mes3, 
                              :x => 25, :y => 110,
                              :font_size => 12,
                              :color => [255, 255, 255],  # フォント色を白色に設定
                              :bold => true)

    # ゲームスタートを促すメッセージを作成
    @announce_text = Text.new("●●●●●スペースキーを押してください●●●●●", 
                              :color => [255, 187, 255],  # フォント色を黄色に設定
                              :y => 555, :bold => true)


  end

  def draw
    Window.draw(0, 0, @title_image)
    @describe_text.each do |text|
   	text.draw
    end
    @announce_text.draw

  end

  def play
    draw
    if Input.keyPush?(K_SPACE)
      Scene.set_current_scene(:game)
    end
  end
end
