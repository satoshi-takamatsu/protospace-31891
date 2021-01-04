class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    # 下記で作ったprivate内のcomment_paramsを投稿するというコード
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      # binding.pry
      # prototypeとcommentテーブルはアソシエーションを結んでいるので、下記の記述が可能
      # コメント不可で戻って来た時に、保存しているprototypeを引っ張ってくるコード
      # @comment.prototype 
      @prototype = @comment.prototype
      # binding.pry
      # コメント不可で戻ってきた時に、コメントをDBから引っ張ってくるコード
      @comments = @prototype.comments
      render "prototypes/show"
      # view/prototypes/show.html.erbに遷移するというコード
    end
  end

  # commentコントローラーには表示機能はつける必要がない、prototypeコントローラーで表示機能はつける
  # prototypeとcommentはアソシエーションを結んでいるので、commentコントローラーを情報をprototypeコントローラーに引っ張っている
  # def show
  # end


  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
# mergeでprototype_id と prototypesテーブルのparams[:prototype_id]を紐付けた？
# 不明点残る