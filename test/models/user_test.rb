require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#find_or_create_by_oauth returns existing user" do
    user = nil
    assert_no_difference 'User.count' do
      user = User.find_or_create_by_oauth(
        OpenStruct.new({id: 'google_remote_id', full_name: 'name'}))
    end
    assert_equal users(:google_user).id, user.id
  end

  test "#find_or_create_by_oauth creates user if none exists" do
    user = nil
    assert_difference ['User.count', 'OAuth.count'] do
      user = User.find_or_create_by_oauth(
        OpenStruct.new({id: 'NON-EXISTING', full_name: 'user name'}))
    end
    assert user
    assert_equal 'user name', user.full_name
    assert_equal 'NON-EXISTING', user.o_auths.first.remote_id
  end
end
