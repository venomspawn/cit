# frozen_string_literal: true

# Tests of REST API method which returns information on a doomsday machine

RSpec.describe CIT::API::REST::DoomsdayMachines::Show do
  describe 'GET /doomsday_machines/:id' do
    include described_class::SpecHelper

    subject(:response) { get "/doomsday_machines/#{id}" }

    let(:id) { doomsday_machine.id }
    let(:doomsday_machine) { create(:doomsday_machine) }

    it 'should invoke CIT::Actions::DoomsdayMachines.show' do
      expect(CIT::Actions::DoomsdayMachines)
        .to receive(:show)
        .and_call_original
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
