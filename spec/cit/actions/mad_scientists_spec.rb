# frozen_string_literal: true

# Tests of actions on records of mad scientists

RSpec.describe CIT::Actions::MadScientists do
  describe 'the module' do
    subject { described_class }

    it { is_expected.to respond_to(:create, :destroy) }
  end

  describe '.create' do
    include described_class::Create::SpecHelper

    subject(:result) { described_class.create(params, rest) }

    let(:params) { data }
    let(:data) { attributes_for(:mad_scientist).except(:id, :created_at) }
    let(:rest) { nil }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }
    end

    it 'should create new record of mad scientists' do
      expect { subject }.to change { CIT::Models::MadScientist.count }.by(1)
    end
  end

  describe '.destroy' do
    subject { described_class.destroy(params, rest) }

    let(:params) { data }
    let(:data) { { id: id } }
    let!(:id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }
    let(:rest) { nil }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    it 'should destroy the record of mad scientist with provided identifier' do
      expect { subject }.to change { CIT::Models::MadScientist.count }.by(-1)
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end

    context 'when there is a record of a doomsday machine of the scientist' do
      let!(:doomsday_machine) { create(:doomsday_machine, traits) }
      let(:traits) { { mad_scientist_id: id } }

      it 'should raise Sequel::ForeignKeyConstraintViolation' do
        expect { subject }
          .to raise_error(Sequel::ForeignKeyConstraintViolation)
      end
    end
  end
end
