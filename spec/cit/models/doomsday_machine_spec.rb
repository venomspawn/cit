# frozen_string_literal: true

RSpec.describe CIT::Models::DoomsdayMachine do
  describe 'the model' do
    subject { described_class }

    it { is_expected.to respond_to(:new, :create) }
  end

  describe '.new' do
    subject(:result) { described_class.new(params) }

    describe 'result' do
      subject { result }

      let(:params) { attributes_for(:doomsday_machine).except(:id) }

      it { is_expected.to be_an_instance_of(described_class) }
    end

    context 'when `params` contains `id` attribute' do
      let(:params) { attributes_for(:doomsday_machine) }

      it 'should raise Sequel::MassAssignmentRestriction' do
        expect { subject }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end
  end

  describe '.create' do
    subject(:result) { described_class.create(params) }

    describe 'result' do
      before { described_class.unrestrict_primary_key }

      after { described_class.restrict_primary_key }

      subject { result }

      let(:params) { attributes_for(:doomsday_machine) }

      it { is_expected.to be_a(described_class) }
    end

    context 'when `params` contains `id` attribute' do
      let(:params) { attributes_for(:doomsday_machine) }

      it 'should raise Sequel::MassAssignmentRestriction' do
        expect { subject }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'when `params` doesn\'t contain `id` attribute' do
      let(:params) { attributes_for(:doomsday_machine).except(:id) }

      it 'should raise Sequel::NotNullConstraintViolation' do
        expect { subject }.to raise_error(Sequel::NotNullConstraintViolation)
      end
    end

    context 'when primary key is unrestricted' do
      before { described_class.unrestrict_primary_key }

      after { described_class.restrict_primary_key }

      context 'when value of `id` property is nil' do
        let(:params) { attributes_for(:doomsday_machine, id: value) }
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end

      context 'when value of `id` property is of String' do
        context 'when the value is not of UUID format' do
          let(:params) { attributes_for(:doomsday_machine, id: value) }
          let(:value) { 'not of UUID format' }

          it 'should raise Sequel::DatabaseError' do
            expect { subject }.to raise_error(Sequel::DatabaseError)
          end
        end
      end

      context 'when value of `name` property is nil' do
        let(:params) { attributes_for(:doomsday_machine, name: value) }
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end

      context 'when value of `power` property is nil' do
        let(:params) { attributes_for(:doomsday_machine, power: value) }
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end

      context 'when value of `power` property is a negative number' do
        let(:params) { attributes_for(:doomsday_machine, power: value) }
        let(:value) { -1 }

        it 'should raise Sequel::CheckConstraintViolation' do
          expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
        end
      end

      context 'when value of `power` property is of String' do
        context 'when the value is not a number\'s representation' do
          let(:params) { attributes_for(:doomsday_machine, power: value) }
          let(:value) { 'not a number\'s representation' }

          it 'should raise Sequel::InvalidValue' do
            expect { subject }.to raise_error(Sequel::InvalidValue)
          end
        end

        context 'when the value is a negative number\'s representation' do
          let(:params) { attributes_for(:doomsday_machine, power: value) }
          let(:value) { '-1' }

          it 'should raise Sequel::CheckConstraintViolation' do
            expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
          end
        end
      end

      context 'when value of `created_at` property is nil' do
        let(:params) { attributes_for(:doomsday_machine, created_at: value) }
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end

      context 'when value of `created_at` property is of String' do
        context 'when the value is not a time\'s representation' do
          let(:params) { attributes_for(:doomsday_machine, traits) }
          let(:traits) { { created_at: value } }
          let(:value) { 'not a time\'s representation' }

          it 'should raise Sequel::InvalidValue' do
            expect { subject }.to raise_error(Sequel::InvalidValue)
          end
        end
      end

      context 'when value of `mad_scientist_id` property is nil' do
        let(:params) { attributes_for(:doomsday_machine, traits) }
        let(:traits) { { mad_scientist_id: value } }
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end

      context 'when value of `mad_scientist_id` is not a primary key' do
        let(:params) { attributes_for(:doomsday_machine, traits) }
        let(:traits) { { mad_scientist_id: value } }
        let(:value) { create(:uuid) }

        it 'should raise Sequel::ForeignKeyConstraintViolation' do
          expect { subject }
            .to raise_error(Sequel::ForeignKeyConstraintViolation)
        end
      end
    end
  end

  describe 'instance of the model' do
    subject(:instance) { create(:doomsday_machine) }

    messages = %i[id name power created_at mad_scientist_id update]
    it { is_expected.to respond_to(*messages) }
  end

  describe '#id' do
    subject(:result) { instance.id }

    describe 'result' do
      subject { result }

      let(:instance) { create(:doomsday_machine) }

      it { is_expected.to be_a(String) }
      it { is_expected.to match_uuid_format }
    end
  end

  describe '#name' do
    subject(:result) { instance.name }

    let(:instance) { create(:doomsday_machine) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(String) }
    end
  end

  describe '#power' do
    subject(:result) { instance.power }

    let(:instance) { create(:doomsday_machine) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_an(Integer) }
      it { is_expected.to be >= 0 }
    end
  end

  describe '#created_at' do
    subject(:result) { instance.created_at }

    let(:instance) { create(:doomsday_machine) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(Time) }
    end
  end

  describe '#mad_scientist_id' do
    subject(:result) { instance.mad_scientist_id }

    describe 'result' do
      subject { result }

      let(:instance) { create(:doomsday_machine) }

      it { is_expected.to be_a(String) }
      it { is_expected.to match_uuid_format }
    end
  end

  describe '#update' do
    subject(:result) { instance.update(params) }

    let(:instance) { create(:doomsday_machine) }

    context 'when id is specified' do
      let(:params) { { id: create(:uuid) } }

      it 'should raise Sequel::MassAssignmentRestriction' do
        expect { subject }.to raise_error(Sequel::MassAssignmentRestriction)
      end
    end

    context 'when `name` property is present in parameters' do
      let(:params) { { name: value } }

      context 'when the value is of String' do
        let(:value) { create(:string) }

        it 'should set `name` attribute of the instance to the value' do
          expect { subject }.to change { instance.name }.to(value)
        end
      end

      context 'when the value is nil' do
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end

    context 'when `power` property is present in parameters' do
      let(:params) { { power: value } }

      context 'when the value is of String' do
        context 'when the value is a number\'s representation' do
          let(:value) { number.to_s }

          context 'when the number is negative' do
            let(:number) { -1 }

            it 'should raise Sequel::CheckConstraintViolation' do
              expect { subject }
                .to raise_error(Sequel::CheckConstraintViolation)
            end
          end

          context 'when the number is not negative' do
            before { subject }

            let(:number) { 1 }

            it 'should set `power` attribute to the number' do
              expect(instance.power).to be == number
            end
          end
        end

        context 'when the value is not a number\'s representation' do
          let(:value) { 'not a number\'s representation' }

          it 'should raise Sequel::InvalidValue' do
            expect { subject }.to raise_error(Sequel::InvalidValue)
          end
        end
      end

      context 'when the value is of Integer' do
        context 'when the value is negative' do
          let(:value) { -1 }

          it 'should raise Sequel::CheckConstraintViolation' do
            expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
          end
        end

        context 'when the value is not negative' do
          before { subject }

          let(:value) { 1 }

          it 'should set `power` attribute to the value' do
            expect(instance.power).to be == value
          end
        end
      end

      context 'when the value is nil' do
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end

    context 'when `created_at` property is present in parameters' do
      let(:params) { { created_at: value } }

      context 'when the value is of String' do
        context 'when the value is a time\'s representation' do
          before { subject }

          let(:value) { created_at.to_s }
          let(:created_at) { Time.now - 1 }

          it 'should set `created_at` attribute to the date' do
            expect(instance.created_at).to be_within(1).of(created_at)
          end
        end

        context 'when the value is not a time\'s representation' do
          let(:value) { 'not a time\'s representation' }

          it 'should raise Sequel::InvalidValue' do
            expect { subject }.to raise_error(Sequel::InvalidValue)
          end
        end
      end

      context 'when the value is of Time' do
        before { subject }

        let(:value) { Time.now - 1 }

        it 'should set `created_at` attribute to the value' do
          expect(instance.created_at).to be_within(1).of(value)
        end
      end

      context 'when the value is nil' do
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end

    context 'when `mad_scientist_id` property is present in parameters' do
      let(:params) { { mad_scientist_id: value } }

      context 'when the value is of String' do
        context 'when the value is an UUID' do
          context 'when the value is not a primary key' do
            let(:value) { create(:uuid) }

            it 'should raise Sequel::ForeignKeyConstraintViolation' do
              expect { subject }
                .to raise_error(Sequel::ForeignKeyConstraintViolation)
            end
          end

          context 'when the value is a primary key' do
            before { subject }

            let(:value) { create(:mad_scientist).id }

            it 'should set `mad_scientist_id` attribute to the value' do
              expect(instance.mad_scientist_id).to be == value
            end
          end
        end

        context 'when the value isn\'t an UUID' do
          let(:value) { 'isn\'t an UUID' }

          it 'should raise Sequel::DatabaseError' do
            expect { subject }.to raise_error(Sequel::DatabaseError)
          end
        end
      end

      context 'when the value is nil' do
        let(:value) { nil }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end
  end
end
