require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    Warden.test_mode!
  end

  test "ログインしていなければログインページを表示" do
    get root_path
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_select 'h2', 'Log in'
  end

  test "ログインしていれば Welcome メッセージを表示" do
    user = User.create! email: 'foo@example.com', password: '12345678'
    login_as(user, :scope => :user)

    get root_path
    assert_equal root_path, current_path
    assert_select 'h1', 'Welcome, foo@example.com!'
  end
end
