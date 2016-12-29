module Plino
  ##
  # This class is used for classification of texts as spam or ham
  class Classifier
    SPAM = 'spam'.freeze
    HAM = 'ham'.freeze

    def spam?(text)
      classifies_as?(SPAM, text)
    end

    def ham?(text)
      !spam?(text)
    end

    private

    def classifies_as?(email_class, text)
      classify(text) == email_class
    end

    def classify(text)
      client.classify(text)[:email_class]
    end

    def client
      @client ||= Client.new
    end
  end
end
