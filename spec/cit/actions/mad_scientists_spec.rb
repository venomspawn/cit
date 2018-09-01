# frozen_string_literal: true

# Tests of actions on records of mad scientists

RSpec.describe CIT::Actions::MadScientists do
  describe 'the module' do
    subject { described_class }

    it { is_expected.to respond_to(:create) }
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
end
