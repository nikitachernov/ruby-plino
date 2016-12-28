require 'spec_helper'

module Plino
  describe Classifier do
    let(:classifier) { Classifier.new }
    let(:text) { 'Foobar' }

    let(:response) do
      {
        email_class: email_class,
        email_text: text,
        status: 200
      }
    end

    before do
      client = double(Client)
      allow(classifier).to receive(:client) { client }
      allow(client).to receive(:classify) { response }
    end

    describe '#spam?' do
      context 'when spam' do
        let(:email_class) { Classifier::SPAM }

        it 'should return true' do
          result = classifier.spam?(text)
          expect(result).to eq true
        end
      end

      context 'when ham' do
        let(:email_class) { Classifier::HAM }

        it 'should return false' do
          result = classifier.spam?(text)
          expect(result).to eq false
        end
      end
    end

    describe '#ham?' do
      context 'when spam' do
        let(:email_class) { Classifier::SPAM }

        it 'should return false' do
          result = classifier.ham?(text)
          expect(result).to eq false
        end
      end

      context 'when ham' do
        let(:email_class) { Classifier::HAM }

        it 'should return true' do
          result = classifier.ham?(text)
          expect(result).to eq true
        end
      end
    end
  end
end
