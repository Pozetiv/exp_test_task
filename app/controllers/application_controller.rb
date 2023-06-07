class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_or_create_by(device_token: request.headers['Device-Token']) # заглушка под device или других гемов
  end
end
