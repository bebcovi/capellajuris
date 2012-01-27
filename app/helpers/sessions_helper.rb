module SessionsHelper
  def user_already_registered?
    User.any?
  end
end
