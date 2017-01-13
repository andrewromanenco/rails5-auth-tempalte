require 'test_helper'

module Registration
  class GoogleServiceTest < ActiveSupport::TestCase
    test "#user_id returns id for a valid token" do
      GooglePlus::Person.stubs(:get).returns(OpenStruct.new({id: '12345'}))

      testee = GoogleService.new 'some-token'
      assert_equal '12345', testee.user_id
    end

    test "#user_id raises InfoNotAvailable exception on error" do
      GooglePlus::Person.stubs(:get).raises(RuntimeError)

      testee = GoogleService.new 'some-token'
      assert_raises InfoNotAvailable do
        testee.user_id
      end
    end

    test "#full_name returns full name for a valid token" do
      GooglePlus::Person.stubs(:get).returns(OpenStruct.new({display_name: 'Full Name'}))

      testee = GoogleService.new 'some-token'
      assert_equal 'Full Name', testee.full_name
    end

    test "#full_name raises InfoNotAvailable exception on error" do
      GooglePlus::Person.stubs(:get).raises(RuntimeError)

      testee = GoogleService.new 'some-token'
      assert_raises InfoNotAvailable do
        testee.full_name
      end
    end
  end
end
