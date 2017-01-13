require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
    #OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      'token' => 'valid-access-token',
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test "create session sets user id" do
    Registration::GoogleService.any_instance.stubs(:user_id).returns('remote-user-id')
    Registration::GoogleService.any_instance.stubs(:full_name).returns('John Doe')
    get session_create_url(provider: :google_oauth2)
    assert_redirected_to root_url
    assert session[:current_user_id]
  end
end
