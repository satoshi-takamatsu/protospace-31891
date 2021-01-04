class PrototypesController < ApplicationController
  # before_action コントローラーで定義されたアクションを行う前に指定の処理を行う
  # :authenticate_user!メソッドはログインしていなければ必ずログイン画面に遷移させるコード
  # exceptオプションは、指定アクションの前はbefore_actionを無効にするコード
  # onlyオプションは、指定アクションの前だけ、before_actionを有効にするコード
  
  # before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  # ログアウト時にアドレス直接入力でeditにアクセスするのをブロックするために、:editを追加

  # authenticate_user!を使っているので、追加でbefore_actionを使わない、上記にeditを追加、下記のprivateの中にauthenticate_user!の変数を定義し処理を記入
  # before_action :move_to_index, only: :edit
  
  # indexアクションで、prototypeテーブルの情報を全て取得
  def index
    @prototypes = Prototype.all
  end

  # newアクションで、prototypeテーブルのレコードを新規生成＝新規登録が出来る
  def new
    # 投稿画面でform_withに使うインスタンス変数を設定
    @prototype = Prototype.new
  end

  # createアクションで、newで新規生成したレコードに保存 prototype_paramsを保存
  def create
    @prototype = Prototype.new(prototype_params)
    # if文で、保存が出来たらトップページ(indexだから)に遷移、nilなら新規投稿ページに戻る 
    if @prototype.save
      # render 'index'
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # (params[:id])の()を忘れないように
    @prototype = Prototype.find(params[:id])
    # prototypeのviewファイルのshowで、commentコントローラーのアクションを表示させるために、ここでComment.newを@commentに代入
    @comment = Comment.new
    # prototypeとcommentモデルのアソシエーションの関係とN＋１問題への対応
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # NG1 @prototype = Prototype.save(params[:id])
    @prototype = Prototype.find(params[:id])
    # 
    unless @prototype.user_id == current_user.id
      redirect_to root_path
    end
    # !!更新完了後のページ遷移をeditでやろうとしてミス、editは投稿編集ページを表示するためのアクション //
    # binding.pry
    # if @prototype.save
    #   render :show
    # end
    # //

    # ログアウト状態でアドレス直接入力を防ぐためのunlessメソッドの記述は、editにしない →→ これは間違い！
    # @prototype.idに記述が足りないからエラーが出た。→正 @prototype.user_id
    # unless @prototype.id == current_user.id
    #   redirect_to :index
    # end
  end

  # ビューファイルにprototype情報を受け渡す必要がないので、インスタンスは使用しない
  def update
    # binding.pry
    # @comment = Comment.find(params[:id])
    # 上記ではレコードは取得出来るが表示はされない
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      # もし更新が成功したら、もう一度Commentレコードを取得する必要がある
      # 下記の記述がない場合、undefined method `to_model' for #<Comment::ActiveRecord_Associations_CollectionProxy:0x00007f8f0f39a468> のエラーが出る
      # .new は新規投稿ページを表示するという合図のコード。情報の取得は出来ない
      @comment = Comment.new
      render :show
    else
      render :edit
    end
    # render でページ遷移をするときは、遷移先のアクション名を記述 :アクション名

  end

  def destroy
    @prototype = Prototype.find(params[:id])
    # if文は使わない→if文はtrueとfalseの場合の処理を書く、deleteは必ずtrueになるから
    @prototype.destroy
    redirect_to root_path
    # redirect_to でページ遷移をするときは、Prefixを記述
  end

  # private以下に記述することでこのコントローラ内でしか取り出せないようにする セキュリティー強化
  # 補足：コントローラー内でしか呼び出すことが出来ない
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  # require(箱 or DBのテーブル名).permit(:カラム名 取得したいもの).merge(指定カラムに別の情報を紐付ける/上記はprototypeのuser_idにcurrent_user.idを紐付けた)

  # ログイン状態で別ユーザーのeditにアドレス直接入力のアクセスはここでは記述できない。→editアクション内で記述
  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path
    end
  end

  # アドレスの直接入力を防ぐコードは下記のようにアクションを分けてもできるが、上記のauthenticate_user!にまとめてしまっても出来た。まとめたほうがコードが少なくなるので今回はこれを採用する
  # def move_to_index
  #   unless user_signed_in?
  #     redirect_to action: :edit
  #   end
  # end
end

