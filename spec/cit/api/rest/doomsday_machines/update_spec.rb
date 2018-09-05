# frozen_string_literal: true

# Tests of REST API method which updates information on a doomsday machine

RSpec.describe CIT::API::REST::DoomsdayMachines::Update do
  describe 'PUT /doomsday_machines/:id' do
    subject(:response) { put "/doomsday_machines/#{id}", request_body }

    let(:id) { doomsday_machine.id }
    let(:doomsday_machine) { create(:doomsday_machine) }
    let(:request_body) { Oj.dump(params) }
    let(:params) { { name: create(:string), power: create(:integer) } }

    it 'should invoke CIT::Actions::DoomsdayMachines.update' do
      expect(CIT::Actions::DoomsdayMachines)
        .to receive(:update)
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
