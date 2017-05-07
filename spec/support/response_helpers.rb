# frozen_string_literal: true

module Response
  module JsonHelpers
    def json
      @json_response ||= JSON.parse(response.body)
    end

    def errors
      json['errors']
    end
  end
end
