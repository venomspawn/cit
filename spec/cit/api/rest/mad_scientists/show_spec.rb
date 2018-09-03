# frozen_string_literal: true

# Tests of REST API method which returns information on a mad scientist

RSpec.describe CIT::API::REST::MadScientists::Show do
  describe 'GET /mad_scientists/:id' do
    include described_class::SpecHelper

    subject(:response) { get "/mad_scientists/#{id}" }

    let(:id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }

    it 'should invoke CIT::Actions::MadScientists.show' do
      expect(CIT::Actions::MadScientists).to receive(:show).and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_ok }

        context 'when the record can\'t be found by provided identifier' do
          let(:id) { create(:uuid) }

          it { is_expected.to be_not_found }
        end
      end

      describe 'body' do
        subject { response.body }

        it { is_expected.to match_json_schema(schema) }
      end
    end
  end
end
