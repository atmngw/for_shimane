# ゲームウィンドウ上へ描画する文字列を管理するクラス定義
class Text
  # テキストの描画座標は後から取得できるよう、アクセサメソッドを定義しておく
  attr_reader :x, :y

  # ウィンドウ描画文字列が備えるべき属性を設定する初期化処理。
  def initialize(text, opt = {})
    # オブジェクトが描画すべきテキスト内容をインスタンス変数に確保。
    @text = text

    # 三項演算子（if～else～end構文を1行で書く記法）を用いたパラメータ値の
    # 受け取り（指定が無いものにはデフォルト値を適用する。
    @x     = opt[:x]     ? opt[:x].to_i     : nil             # テキスト描画位置のX座標
    @y     = opt[:y]     ? opt[:y].to_i     : 0               # テキスト描画位置のY座標
    @alpha = opt[:alpha] ? opt[:alpha].to_i : 255             # α値（透明度）。255は完全不透明。0が透明
    @color = opt[:color] ? opt[:color]      : [255, 255, 255] # 表示色。RGBの3原色を配列で指定する。

    # 同じく三項演算子を使って使用するフォントの定義を受け取る。
    font_name = opt[:font_name] ? opt[:font_name].to_s : "ＭＳ ゴシック"
    font_size = opt[:font_size] ? opt[:font_size].to_i : 20
    bold      = opt[:bold]      ? opt[:bold]           : false
    italic    = opt[:italic]    ? opt[:italic]         : false

    # 描画に使用するフォントの生成
    @font = Font.new(font_size, font_name, :weight => bold, :italic => italic)

    # @xの値が指定されていない時は、センタリングして表示するよう、@xを計算する。
    # 「Window.width」でウィンドウの横幅を、「@font.getWidth(@text)」でテキスト
    # の描画時の横幅をそれぞれ取得できるので、そこから中央値を計算。
    unless @x
      @x = (Window.width - @font.getWidth(@text)) / 2
    end
  end

  # せっかくなのでテキストをスクロールできるようにしてみる
  def scroll(dy)
    # 1フレームで移動するスクロール量dyを受け取り、テキストの描画座標（のY座標）
    # に足し込む。
    # 本メソッド実行後にdrawメソッドを呼び出すと、dy > 0 ならば下方向へスクロールし、
    # dy < 0 ならば上方向へスクロールする。
    @y += dy
  end

  # 実際にウィンドウ上の特定座標にテキストを描画するメソッド定義
  def draw
    Window.drawFont(@x, @y, @text, @font, :alpha => @alpha, :color => @color)
  end
end
