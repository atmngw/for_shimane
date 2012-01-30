class Title
  def initialize
    @title_image = Image.load("images/top4.3.bmp")
    str  = "���܂˂̂��߂�\n"
    mes1 = "�����炷��"
    mes2 = "�@�o�_��ЂɃI�o�P���ł�悤�ɂȂ��āA���܂˂�������񂪍����Ă��܂�"
    mes3 = "�@���ƃX�y�[�X�L�[�ł��������𓮂����āA
  ���܂˂�������������āI"
    @describe_text = Array.new
    @describe_text << Text.new(str, 
                              :x => 18, :y => 20,
                              :font_size => 50,
                              :color => [255, 255, 255],  # �t�H���g�F�𔒐F�ɐݒ�
                              :bold => true)
    @describe_text << Text.new(mes1, 
                              :x => 25, :y => 80,
                              :font_size => 10,
                              :color => [255, 255, 255],  # �t�H���g�F�𔒐F�ɐݒ�
                              :bold => true)
    @describe_text << Text.new(mes2, 
                              :x => 25, :y => 95,
                              :font_size => 12,
                              :color => [255, 255, 255],  # �t�H���g�F�𔒐F�ɐݒ�
                              :bold => true)
   @describe_text << Text.new(mes3, 
                              :x => 25, :y => 110,
                              :font_size => 12,
                              :color => [255, 255, 255],  # �t�H���g�F�𔒐F�ɐݒ�
                              :bold => true)

    # �Q�[���X�^�[�g�𑣂����b�Z�[�W���쐬
    @announce_text = Text.new("�����������X�y�[�X�L�[�������Ă�����������������", 
                              :color => [255, 187, 255],  # �t�H���g�F�����F�ɐݒ�
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
