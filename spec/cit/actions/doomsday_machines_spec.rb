# frozen_string_literal: true

# Tests of actions on records of doomsday machines

RSpec.describe CIT::Actions::DoomsdayMachines do
  describe 'the module' do
    subject { described_class }

    it { is_expected.to respond_to(:create, :destroy, :index, :show) }
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

  describe '.index' do
    include described_class::Index::SpecHelper

    subject(:result) { described_class.index(params, rest) }

    let(:params) { data }
    let(:data) { { mad_scientist_id: mad_scientist_id } }
    let(:mad_scientist_id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }
    let(:rest) { nil }
    let!(:doomsday_machines) { create_doomsday_machines(mad_scientist_id) }

    it_should_behave_like 'an action parameters receiver',
                          wrong_structure: { page: 'wrong' }

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }

      describe 'size' do
        subject { result.size }

        context 'when `page_size` parameter value is provided' do
          let(:params) { { page_size: page_size, **data } }
          let(:page_size) { 2 }

          it 'should be less than the value or equal it' do
            expect(subject).to be <= page_size
          end
        end

        context 'when `page_size` parameter value is not provided' do
          value = 'CIT::Actions::DoomsdayMachines::Index::DEFAULT_PAGE_SIZE'
          it "should be less than #{value} or equal it" do
            expect(subject).to be <= described_class::Index::DEFAULT_PAGE_SIZE
          end
        end
      end

      describe 'order' do
        context 'when `order` parameter value is a column name' do
          context 'when `direction` parameter value is absent' do
            let(:params) { { order: :name, **data } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == doomsday_machines.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { order: :name, direction: :asc, **data } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == doomsday_machines.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { order: :name, direction: :desc, **data } }

            it 'should be ordered by values of the column descending' do
              expect(result.map { |hash| hash[:name] })
                .to be == doomsday_machines.map(&:name).sort.reverse
            end
          end
        end

        context 'when `order` parameter value is absent' do
          context 'when `direction` parameter value is absent' do
            let(:params) { data }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == doomsday_machines.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { direction: :asc, **data } }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == doomsday_machines.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { direction: :desc, **data } }

            it 'should be ordered by values of `id` column descending' do
              expect(result.map { |hash| hash[:id] })
                .to be == doomsday_machines.map(&:id).sort.reverse
            end
          end
        end
      end
    end

    context 'when the record of mad scientist can\'t be found' do
      let(:mad_scientist_id) { create(:uuid) }
      let!(:doomsday_machines) { [] }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end

  describe '.show' do
    include described_class::Show::SpecHelper

    subject(:result) { described_class.show(params, rest) }

    let(:params) { data }
    let(:data) { { id: id } }
    let(:id) { doomsday_machine.id }
    let(:doomsday_machine) { create(:doomsday_machine) }
    let(:rest) { nil }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end

  describe '.update' do
    subject { described_class.update(params, rest) }

    let(:params) { data }
    let(:data) { { id: id, **update_params } }
    let(:id) { doomsday_machine.id }
    let(:doomsday_machine) { create(:doomsday_machine) }
    let(:update_params) { { name: create(:string), power: create(:integer) } }
    let(:rest) { nil }

    it_should_behave_like 'an action parameters receiver', wrong_structure: {}

    it 'should update fields of record of the mad scientist' do
      subject
      doomsday_machine.reload
      expect(doomsday_machine.name).to be == update_params[:name]
      expect(doomsday_machine.power).to be == update_params[:power]
    end

    context 'when the record can\'t be found by provided identifier' do
      let(:id) { create(:uuid) }

      it 'should raise Sequel::NoMatchingRow' do
        expect { subject }.to raise_error(Sequel::NoMatchingRow)
      end
    end
  end
end
