class Ending
  def initialize
    @ending_image = Image.load("images/gameclear.bmp")

    @staff_roll = []
    @staff_roll << "���߂łƂ��������܂��I"
    @staff_roll << "���Ȃ��̂������ŏo�_�͕��a�����߂��܂����I"
    @staff_roll << ""
    @staff_roll << "[STAFF]"
    @staff_roll << "�V�i���I�F             �R�{����"
    @staff_roll << "�L�����N�^�[�f�U�C���F �k�R��"
    @staff_roll << "�v���O���}�F           ����M��"
    @staff_roll << "�v���O���}�F           �F��֋I"
    @staff_roll << "����E���w���F         ��q�וF"
    @staff_roll << ""
    @staff_roll << ""
    @staff_roll << "               �`Fin�`"
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
