Rails.application.routes.draw do
  # get 'users/show'
  # controller作成時に自動で生成。これが残っていると、routesでusers/showができてしまう。不要なので削除
  devise_for :users
  root to: 'prototypes#index'

  # 下記は、7つのアクションを全て使う記述、onlyオプションでアクションの指定をする、使うアクションが少ない時はonlyを使うこと
  # 7つのアクションが揃ったので、onlyオプションをはずしまとめる
  # resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  resources :prototypes do
  # commentsコントローラーはprototypesコントローラーとネスト関係にする
  # ネスト関係→親のコントローラー内のビューファイルで使用するコントローラーが子になる
  # ！コメント実装でroute errorが出たが、原因はここではなかった。contollerのshowの記述に誤り
    resources :comments, only: [:index, :create]
    # resources :users, only: :show 
  end

  resources :users, only: :show
end
