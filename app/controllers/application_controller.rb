class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    game_path
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
