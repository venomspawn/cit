# frozen_string_literal: true

# Tests of REST API method which updates information on a mad scientist

RSpec.describe CIT::API::REST::MadScientists::Update do
  describe 'PUT /mad_scientists/:id' do
    subject(:response) { put "/mad_scientists/#{id}", request_body }

    let(:id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }
    let(:request_body) { Oj.dump(params) }
    let(:params) { attributes_for(:mad_scientist).except(:id, :created_at) }

    it 'should invoke CIT::Actions::MadScientists.update' do
      expect(CIT::Actions::MadScientists).to receive(:update).and_call_original
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
