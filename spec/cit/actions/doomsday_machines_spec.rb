# frozen_string_literal: true

# Tests of actions on records of doomsday machines

RSpec.describe CIT::Actions::DoomsdayMachines do
  describe 'the module' do
    subject { described_class }

    it { is_expected.to respond_to(:create, :destroy) }
  end

  describe '.create' do
    include described_class::Create::SpecHelper

    subject(:result) { described_class.create(params, rest) }

    let(:params) { data }
    let(:data) { attributes_for(:doomsday_machine).except(:id, :created_at) }
    let(:rest) { nil }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }
    end

    it 'should create new record of doomsday machine' do
      expect { subject }.to change { CIT::Models::DoomsdayMachine.count }.by(1)
    end

    context 'when the record of mad scientist can\'t be found' do
      let(:data) { attributes_for(:doomsday_machine, traits).except(*columns) }
      let(:traits) { { mad_scientist_id: create(:uuid) } }
      let(:columns) { %i[id created_at] }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end

  describe '.destroy' do
    subject { described_class.destroy(params, rest) }

    let(:params) { data }
    let(:data) { { id: id } }
    let!(:id) { doomsday_machine.id }
    let(:doomsday_machine) { create(:doomsday_machine) }
    let(:rest) { nil }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    it 'should destroy record of doomsday machine with provided identifier' do
      expect { subject }
        .to change { CIT::Models::DoomsdayMachine.count }
        .by(-1)
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end
end
