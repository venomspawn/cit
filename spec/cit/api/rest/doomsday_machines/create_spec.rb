# frozen_string_literal: true

# Tests of REST API method which creates new record of a doomsday machine

RSpec.describe CIT::API::REST::DoomsdayMachines::Create do
  describe 'POST /mad_scientists/:id/doomsday_machines' do
    include described_class::SpecHelper

    subject(:response) { post url, request_body }

    let(:url) { "/mad_scientists/#{id}/doomsday_machines" }
    let(:id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }
    let(:request_body) { Oj.dump(params) }
    let(:params) { { name: create(:string), power: create(:integer) } }

    it 'should invoke CIT::Actions::DoomsdayMachines.create' do
      expect(CIT::Actions::DoomsdayMachines)
        .to receive(:create)
        .and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_created }

        context 'when the record of mad scientist can\'t be found' do
          let(:id) { create(:uuid) }

          it { is_expected.to be_not_found }
        end

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
