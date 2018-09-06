# frozen_string_literal: true

# Tests of REST API method which destroys record of a mad scientist

RSpec.describe CIT::API::REST::MadScientists::Destroy do
  describe 'DELETE /mad_scientists/:id' do
    subject(:response) { delete "/mad_scientists/#{id}" }

    let(:id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }

    it 'should invoke CIT::Actions::MadScientists.destroy' do
      expect(CIT::Actions::MadScientists)
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

        context 'when there is a linked record of a doomsday machine' do
          let!(:doomsday_machine) { create(:doomsday_machine, traits) }
          let(:traits) { { mad_scientist_id: id } }

          it { is_expected.to be_unprocessable }
        end
      end
    end
  end
end
