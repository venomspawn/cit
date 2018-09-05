# frozen_string_literal: true

# Tests of REST API method which returns information on doomsday machines

RSpec.describe CIT::API::REST::DoomsdayMachines::Index do
  describe 'GET /mad_scientists/:id/doomsday_machines' do
    include described_class::SpecHelper

    subject(:response) { get url, params }

    let(:url) { "/mad_scientists/#{id}/doomsday_machines" }
    let(:id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }
    let(:params) { { order: :name } }
    let!(:doomsday_machines) { create_list(:doomsday_machine, 3, traits) }
    let(:traits) { { mad_scientist_id: id } }

    it 'should invoke CIT::Actions::DoomsdayMachines.index' do
      expect(CIT::Actions::DoomsdayMachines)
        .to receive(:index)
        .and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_ok }

        context 'when the record of mad scientist can\'t be found' do
          let(:id) { create(:uuid) }
          let!(:doomsday_machines) { [] }

          it { is_expected.to be_not_found }
        end

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
