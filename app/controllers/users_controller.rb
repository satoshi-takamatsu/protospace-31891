class UsersController < ApplicationController

  # 下記コメントアウトのNGログは、ページ遷移をusers_show_pathにしていたのが原因でエラーが出ていた
  # users_show_pathではidの紐付けができないため、params[:id]を取り出せない。
  # users_show_pathへ遷移しても、params[:id]を取得することが出来ないためエラーが出続けた。
  def show
    # findは1レコードだけを取得できる
    # where句で取得するカラムの指定、idを取得したい、id番号は指定したくないので、[]で空にする
    # @user = User.where(id: [])
    # binding.pry
    @user = User.find(params[:id])

    # binding.pry
    # @prototype = Prototype.find(params[:id])
    # Prototype.find(params[:id])では、protoypeテーブルのidレコードが1つ取得できる
    # この場合だと、user_idと紐付いているので、prorotype_id＝ページ遷移しているユーザー番号のprototypeを取得してしまう
    # ユーザーと関係がない、prototypeが取得できてしまう

    # binding.pry
    # @prototypes = Prototype.where(:id @user)
    # SyntaxErrorが出る。(id: @user)でも[]になる
    
    # binding.pry
    # @prototypes = Prototype.where(user_id: self.id)
    # NoMethodErrorが出る
    
    # binding.pry
    # @prototypes = Prototype.find_by(id: params[:id])
    # find_byは指定した条件（カラム）を検索できるコード.今回のprototypeは共通点が、user_id＝prototype.idなので不適切
    # Prototype.find_by(id: params[:id])では、ユーザーの１つのprototypeレコードしか取得できない
    # view/users/show.html.erbの_prototypeを呼び出しているrenderメソッドでNoMethodエラーが出る

    # binding.pry
    # @prototypes = Prototype.where("orders_count = ?", params[:id])
    # whereとorderで複数の指定を試みるがエラー
      # view/users/show.html.erbの_prototypeを呼び出しているrenderメソッドでNoMethodエラーが出る

    # binding.pry
    @prototypes = @user.prototypes
    # コメント一覧を表示したときと同じ方法を使う
    # prototypeとuserはアソシエーションの関係にあるので、この記述が成立
    # 一人のユーザーの全てのprototypeを取得出来る


    # 個別にインスタンス変数に代入をしなくても、@user.〇〇でも表示出来る
    @name = @user.name
    @profile = @user.profile
    @occupation = @user.occupation
    @position = @user.position

  end

  # 表示の順番を指定
  # @tweets = user.tweets.includes(:user).order("created_at DESC")
  # includes(:アソシエーションで定義した関連名) 理解不完全なので適宜確認

  # private
  # def user_params
  #   binding.pry
  #   params.require(:user).permit(:name, :profile, :occupation, :position).merge(uesr_id: current_user.id, prototype_id: params[:prototype_id])
  # end
  # application_controllerでユーザー情報は各コントローラーで使えるようにしているから上記はいらない
  # application_controllerは全てのコントローラーで共有できる

end