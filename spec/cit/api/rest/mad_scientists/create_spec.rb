# frozen_string_literal: true

# Tests of REST API method which creates new record of a mad scientist

RSpec.describe CIT::API::REST::MadScientists::Create do
  describe 'POST /mad_scientists' do
    include described_class::SpecHelper

    subject(:response) { post '/mad_scientists', request_body }

    let(:request_body) { Oj.dump(params) }
    let(:params) { attributes_for(:mad_scientist).except(:id, :created_at) }

    it 'should invoke CIT::Actions::MadScientists.create' do
      expect(CIT::Actions::MadScientists).to receive(:create).and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_created }

        context 'when request body is not a JSON-string' do
          let(:request_body) { 'not a JSON-string' }

          it { is_expected.to be_unprocessable }
        end

        context 'when params are wrong' do
          let(:params) { 'wrong' }

          it { is_expected.to be_unprocessable }
        end
      end

      describe 'body' do
        subject { response.body }

        it { is_expected.to match_json_schema(schema) }
      end
    end
  end
end
