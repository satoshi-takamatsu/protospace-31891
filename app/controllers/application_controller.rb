class ApplicationController < ActionController::Base
  # before_action コントローラーで定義されたアクションを行う前に指定の処理を行う
  # :authenticate_user!メソッドはログインしていなければ必ずログイン画面に遷移させるコード
  # before_action :authenticate_user!
  # deviseはサインアップ時にメアドとパスのみを受け取るようにストロングパラメーターでデフォルト設定してある、キーの追加が出来ない
  # configure_permitted_parametersでデフォルト設定にキーの追加を許可するように出来る。
  before_action :configure_permitted_parameters, if: :devise_controller?

  # private=コントローラー内でしか使えない
  private
  def configure_permitted_parameters
    # deviseはカラム追加が出来ない設定なっている
    # devise_prameter_sanitizerメソッドを使うと、deviseのデフォルト設定のstrong_parametersに追加をすることが出来る
    # sign_upの時に、[]内のキーが必要という記述
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end
end
