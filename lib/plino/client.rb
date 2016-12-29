require 'net/http'

module Plino
  ##
  # This class is used for calling Plino API
  class Client
    BASE_URL = 'https://plino.herokuapp.com'.freeze
    CLASSIFY_PATH = '/api/v1/classify/'.freeze

    def classify(text)
      post(CLASSIFY_PATH, email_text: text)
    end

    private

    def post(path, data)
      uri = URI.join(BASE_URL, path)

      request = Net::HTTP::Post.new(uri)
      request.body = data.to_json
      request.set_content_type('application/json')

      http = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true)

      response = http.request(request)

      response = JSON.parse(response.body)

      response.each_with_object({}) do |(k, v), h|
        h[k.to_sym] = v
      end
    end
  end
end
