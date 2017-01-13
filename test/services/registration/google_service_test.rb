require 'test_helper'

module Registration
  class GoogleServiceTest < ActiveSupport::TestCase
    test "#full_name returns full name for valid token" do
      GooglePlus::Person.stubs(:get).returns(OpenStruct.new({display_name: 'Full Name'}))

      testee = GoogleService.new 'some-token'
      assert_equal 'Full Name', testee.full_name
    end

    test "#full_name returns empty string on error" do
      GooglePlus::Person.stubs(:get).raises(RuntimeError)

      testee = GoogleService.new 'some-token'
      assert_equal '', testee.full_name
    end
  end
end
