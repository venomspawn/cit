# frozen_string_literal: true

# Tests of REST API method which returns information on mad scientists

RSpec.describe CIT::API::REST::MadScientists::Index do
  describe 'GET /mad_scientists' do
    include described_class::SpecHelper

    subject(:response) { get '/mad_scientists', params }

    let(:params) { { order: :name } }
    let!(:mad_scientists) { create_list(:mad_scientist, 3) }

    it 'should invoke CIT::Actions::MadScientists.index' do
      expect(CIT::Actions::MadScientists).to receive(:index).and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_ok }

        context 'when params are wrong' do
          let(:params) { { wrong: :structure } }

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
