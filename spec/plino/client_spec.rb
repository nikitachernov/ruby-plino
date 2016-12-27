require 'spec_helper'

module Plino
  describe Client do
    let(:client) { Client.new }

    describe '#classify' do
      let(:response) { client.classify(text) }
      let(:text) { File.read(file) }

      context 'when spam', vcr: { cassette_name: 'spam' } do
        let(:file) { 'spec/fixtures/spam.txt' }

        it 'should classify text as spam' do
          expect(response).to eq(
            email_class: 'spam',
            email_text: text,
            status: 200
          )
        end
      end

      context 'when ham', vcr: { cassette_name: 'ham' } do
        let(:file) { 'spec/fixtures/ham.txt' }

        it 'should classify text as ham' do
          expect(response).to eq(
            email_class: 'ham',
            email_text: text,
            status: 200
          )
        end
      end
    end
  end
end
