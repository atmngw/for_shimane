# �X�N���[���@�\�t��������
# [�|�C���g]
# �ėp�I�ɗp����N���X�ɂ́A�ɗ́u�ŗL�l�v���\�[�X���ɖ��ߍ��܂Ȃ��B
# �K���ϐ��Ɏ���ē��Ă�悤�ɂ��邱�Ƃ��d�v �� �C���Ȃǂ��y�ɂȂ郁���b�g������B
class ScrollText
  def initialize(roll_text_ary, opt = {})
    # �O�����Z�q��p�����I�v�V�����l�̎擾
    @start_y   = opt[:start_y]   ? opt[:start_y].to_i   : Window.height   # �X�N���[���J�n�n�_
    @end_y     = opt[:end_y]     ? opt[:end_y].to_i     : -100            # �X�N���[���I�[�_
    @x         = opt[:x]         ? opt[:x].to_i         : 10              # �`��J�n�_��X���W�l
    @dy        = opt[:dy]        ? opt[:dy].to_i        : -1              # �X�N���[���ʁE����
    @font_size = opt[:font_size] ? opt[:font_size].to_i : 24              # �`��t�H���g�̃T�C�Y
    @color     = opt[:color]     ? opt[:color]          : [255, 255, 255] # �`��F
    @interval  = opt[:interval]  ? opt[:interval].to_i  : 32              # �s���̊Ԋu

    # �X�N���[���ΏۂƂȂ镶������W�߂��z����`
    @view_ary = roll_text_ary

    # 1�s���������Ԋu���󂯂ăX�N���[�����邽�߂̒x���Ǘ��Ɏg���J�E���^��������
    @scroll_cnt = 0

    # ���݉��s�ڂ̃G���f�B���O���[����ǉ����Ă��邩���Ǘ�����ϐ����`
    @current_row = 0

    # ��ʂɕ`�悵������e�L�X�g��ێ������z���p��
    @temp_roll  = []

    # ��ʕ`��p�z��ɍŏ���1�s��ǉ����āA�|�W�V�����ێ��ϐ���1�i�߂�
    add_roll_text(@view_ary[@current_row])
    @current_row += 1
  end

  # 1�t���[�����X�N���[���`������s���郁�\�b�h
  def draw
    # ��ʕ`��p�z��Ɋi�[����Ă���e�s��`�悵�A���ꂼ��1�s�N�Z����փX�N���[��������
    @temp_roll.each_with_index do |text, idx|
      text.scroll(@dy)
      text.draw

      # �X�N���[�����I������A�z�񂩂�Y���s���폜���A�������̈����������B
      # �X�N���[���I�[�_�̔���̓X�N���[�������ɂ���ĈقȂ�̂ŁA�ꍇ��������B
      if @dy < 0
        @temp_roll.delete_at(idx) if text.y < @end_y
      else
        @temp_roll.delete_at(idx) if text.y > @end_y
      end
    end

    # @staff_roll�̍s�����𒴂��Ȃ��悤�A���䂷��
    if @current_row < @view_ary.size

      # �X�N���[������p�̃J�E���^�l��1�i�߂�
      @scroll_cnt += 1

      # �X�N���[������p�̃J�E���^�����ʂɒB������A��ʕ`��p�z���1�s��ǉ����āA
      # �|�W�V�����ێ��ϐ���1�i�߁A�X�N���[������p�J�E���^���N���A����
      if @scroll_cnt == @interval
        add_roll_text(@view_ary[@current_row])
        @current_row += 1
        @scroll_cnt = 0
      end
    end
  end


  # �N���X�����ł����g����\���̖������\�b�h�́Aprivate
  # �錾���Ă����`����ƁA�O�����炤������Ă΂�邱�Ƃ������Ȃ�B
  private

  # ��ʕ\���p�z��ɐV���ȍs��ǉ�����v���C�x�[�g���\�b�h��`
  def add_roll_text(text)
    @temp_roll << Text.new(text, 
                           :x => @x, :y => @start_y, 
                           :font_size => @font_size,
                           :color => @color)
  end
end