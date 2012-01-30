class Ending
  def initialize
    @ending_image = Image.load("images/gameclear.bmp")

    @staff_roll = []
    @staff_roll << "おめでとうございます！"
    @staff_roll << "あなたのおかげで出雲は平和を取り戻しました！"
    @staff_roll << ""
    @staff_roll << "[STAFF]"
    @staff_roll << "シナリオ：             山本実奈"
    @staff_roll << "キャラクターデザイン： 北山明"
    @staff_roll << "プログラマ：           小崎信明"
    @staff_roll << "プログラマ：           皆川敦紀"
    @staff_roll << "制作・総指揮：         大倉泰彦"
    @staff_roll << ""
    @staff_roll << ""
    @staff_roll << "               ～Fin～"
    @scroll_text = ScrollText.new(@staff_roll, :color => [0, 0, 255])
  end

  def draw
    Window.draw(0, 0, @ending_image)
    @scroll_text.draw
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
