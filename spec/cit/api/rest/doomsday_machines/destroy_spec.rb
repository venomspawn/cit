# frozen_string_literal: true

# Tests of REST API method which destroys record of a doomsday machine

RSpec.describe CIT::API::REST::DoomsdayMachines::Destroy do
  describe 'DELETE /doomsday_machines/:id' do
    subject(:response) { delete "/doomsday_machines/#{id}" }

    let(:id) { doomsday_machine.id }
    let(:doomsday_machine) { create(:doomsday_machine) }

    it 'should invoke CIT::Actions::DoomsdayMachines.destroy' do
      expect(CIT::Actions::DoomsdayMachines)
        .to receive(:destroy)
        .and_call_original
      subject
    end

    describe 'response' do
      subject { response }

      describe 'status' do
        it { is_expected.to be_no_content }

        context 'when the record can\'t be found by provided identifier' do
          let(:id) { create(:uuid) }

          it { is_expected.to be_not_found }
        end
      end
    end
  end
end
