# frozen_string_literal: true

# Tests of actions on records of mad scientists

RSpec.describe CIT::Actions::MadScientists do
  describe 'the module' do
    subject { described_class }

    it { is_expected.to respond_to(:create, :destroy, :index, :show) }
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

  describe '.index' do
    include described_class::Index::SpecHelper

    subject(:result) { described_class.index(params, rest) }

    let(:params) { data }
    let(:data) { {} }
    let(:rest) { nil }
    let!(:mad_scientists) { create_mad_scientists }

    it_should_behave_like 'an action parameters receiver',
                          wrong_structure: { page: 'wrong' }

    describe 'result' do
      subject { result }

      it { is_expected.to match_json_schema(schema) }

      describe 'size' do
        subject { result.size }

        context 'when `page_size` parameter value is provided' do
          let(:params) { { page_size: page_size } }
          let(:page_size) { 2 }

          it 'should be less than the value or equal it' do
            expect(subject).to be <= page_size
          end
        end

        context 'when `page_size` parameter value is not provided' do
          value = 'CIT::Actions::MadScientists::Index::DEFAULT_PAGE_SIZE'
          it "should be less than #{value} or equal it" do
            expect(subject).to be <= described_class::Index::DEFAULT_PAGE_SIZE
          end
        end
      end

      describe 'order' do
        context 'when `order` parameter value is a column name' do
          context 'when `direction` parameter value is absent' do
            let(:params) { { order: :name } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == mad_scientists.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { order: :name, direction: :asc } }

            it 'should be ordered by values of the column ascending' do
              expect(result.map { |hash| hash[:name] })
                .to be == mad_scientists.map(&:name).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { order: :name, direction: :desc } }

            it 'should be ordered by values of the column descending' do
              expect(result.map { |hash| hash[:name] })
                .to be == mad_scientists.map(&:name).sort.reverse
            end
          end
        end

        context 'when `order` parameter value is absent' do
          context 'when `direction` parameter value is absent' do
            let(:params) { {} }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == mad_scientists.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `asc`' do
            let(:params) { { direction: :asc } }

            it 'should be ordered by values of `id` column ascending' do
              expect(result.map { |hash| hash[:id] })
                .to be == mad_scientists.map(&:id).sort
            end
          end

          context 'when `direction` parameter value is `desc`' do
            let(:params) { { direction: :desc } }

            it 'should be ordered by values of `id` column descending' do
              expect(result.map { |hash| hash[:id] })
                .to be == mad_scientists.map(&:id).sort.reverse
            end
          end
        end
      end
    end
  end

  describe '.show' do
    include described_class::Show::SpecHelper

    subject(:result) { described_class.show(params, rest) }

    let(:params) { data }
    let(:data) { { id: id } }
    let(:id) { mad_scientist.id }
    let(:mad_scientist) { create(:mad_scientist) }
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
end
