require 'net/http'

module Plino
  class Client
    BASE_URL = 'https://plino.herokuapp.com'
    CLASSIFY_PATH = '/api/v1/classify/'

    def classify(text)
      post(classify_path, email_text: text)
    end

    private

    def base_url
      BASE_URL
    end

    def classify_path
      CLASSIFY_PATH
    end

    def post(path, data)
      uri = URI.join(base_url, path)

      request = Net::HTTP::Post.new(uri)
      request.body = data.to_json
      request.set_content_type("application/json")

      http = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true)

      response = http.request(request)

      response = JSON.parse(response.body)

      response.inject({}) do |h, (k, v)|
        h[k.to_sym] = v
        h
      end
    end
  end
end
