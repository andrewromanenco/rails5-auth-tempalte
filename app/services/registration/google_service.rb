module Registration
  class InfoNotAvailable < StandardError; end

  class GoogleService
    def initialize(access_token)
      @access_token = access_token
    end

    def user_id
      person.id
    end

    def full_name
      person.display_name
    end

    private

    def person
      begin
        @person ||= GooglePlus::Person.get('me', access_token: @access_token)
      rescue RuntimeError => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")
        raise InfoNotAvailable
      end
    end
  end
end
