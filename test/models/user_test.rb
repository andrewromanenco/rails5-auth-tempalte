require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#find_or_create_by_oauth returns existing user" do
    Registration::GoogleService.any_instance.stubs(:user_id).returns('google_remote_id')
    Registration::GoogleService.any_instance.stubs(:full_name).returns('Some User')

    user = nil
    assert_no_difference 'User.count' do
      user = User.find_or_create_by_oauth(Registration::GoogleService.new 'access-token')
    end
    assert_equal users(:google_user).id, user.id
  end

  test "#find_or_create_by_oauth creates user if none exists" do
    Registration::GoogleService.any_instance.stubs(:user_id).returns('NON-EXISTING')
    Registration::GoogleService.any_instance.stubs(:full_name).returns('Some User')

    user = nil
    assert_difference ['User.count', 'OAuth.count'] do
      user = User.find_or_create_by_oauth(Registration::GoogleService.new 'access-token')
    end
    assert user
    assert_equal 'Some User', user.full_name
    assert_equal 'NON-EXISTING', user.o_auths.first.remote_id
  end
end
