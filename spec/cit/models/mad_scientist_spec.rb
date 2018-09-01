# frozen_string_literal: true

RSpec.describe CIT::Models::MadScientist do
  describe 'the model' do
    subject { described_class }

    it { is_expected.to respond_to(:new, :create) }
  end

  describe '.new' do
    subject(:result) { described_class.new(params) }

    describe 'result' do
      subject { result }

      let(:params) { attributes_for(:mad_scientist).except(:id) }

      it { is_expected.to be_an_instance_of(described_class) }
    end
  end

  describe '.create' do
    subject(:result) { described_class.create(params) }

    describe 'result' do
      subject { result }

      let(:params) { attributes_for(:mad_scientist) }

      it { is_expected.to be_a(described_class) }
    end

    context 'when `params` doesn\'t contain `id` property' do
      let(:params) { attributes_for(:mad_scientist).except(:id) }

      it 'should raise Sequel::NotNullConstraintViolation' do
        expect { subject }.to raise_error(Sequel::NotNullConstraintViolation)
      end
    end

    context 'when value of `id` property is nil' do
      let(:params) { attributes_for(:mad_scientist, id: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end

    context 'when value of `id` property is of String' do
      context 'when the value is not of UUID format' do
        let(:params) { attributes_for(:mad_scientist, id: value) }
        let(:value) { 'not of UUID format' }

        it 'should raise Sequel::DatabaseError' do
          expect { subject }.to raise_error(Sequel::DatabaseError)
        end
      end
    end

    context 'when `params` doesn\'t contain `name` property' do
      let(:params) { attributes_for(:mad_scientist).except(:name) }

      it 'should raise Sequel::NotNullConstraintViolation' do
        expect { subject }.to raise_error(Sequel::NotNullConstraintViolation)
      end
    end

    context 'when value of `name` property is nil' do
      let(:params) { attributes_for(:mad_scientist, name: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end

    context 'when value of `madness` property is nil' do
      let(:params) { attributes_for(:mad_scientist, madness: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end

    context 'when value of `madness` property is a negative number' do
      let(:params) { attributes_for(:mad_scientist, madness: value) }
      let(:value) { -1 }

      it 'should raise Sequel::CheckConstraintViolation' do
        expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
      end
    end

    context 'when value of `madness` property is of String' do
      context 'when the value is not a number\'s representation' do
        let(:params) { attributes_for(:mad_scientist, madness: value) }
        let(:value) { 'not a number\'s representation' }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end

      context 'when the value is a negative number\'s representation' do
        let(:params) { attributes_for(:mad_scientist, madness: value) }
        let(:value) { '-1' }

        it 'should raise Sequel::CheckConstraintViolation' do
          expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
        end
      end
    end

    context 'when value of `tries` property is nil' do
      let(:params) { attributes_for(:mad_scientist, tries: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end

    context 'when value of `tries` property is a negative number' do
      let(:params) { attributes_for(:mad_scientist, tries: value) }
      let(:value) { -1 }

      it 'should raise Sequel::CheckConstraintViolation' do
        expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
      end
    end

    context 'when value of `tries` property is of String' do
      context 'when the value is not a number\'s representation' do
        let(:params) { attributes_for(:mad_scientist, tries: value) }
        let(:value) { 'not a number\'s representation' }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end

      context 'when the value is a negative number\'s representation' do
        let(:params) { attributes_for(:mad_scientist, tries: value) }
        let(:value) { '-1' }

        it 'should raise Sequel::CheckConstraintViolation' do
          expect { subject }.to raise_error(Sequel::CheckConstraintViolation)
        end
      end
    end

    context 'when `params` doesn\'t contain `created_at` property' do
      let(:params) { attributes_for(:mad_scientist).except(:created_at) }

      it 'should raise Sequel::NotNullConstraintViolation' do
        expect { subject }.to raise_error(Sequel::NotNullConstraintViolation)
      end
    end

    context 'when value of `created_at` property is nil' do
      let(:params) { attributes_for(:mad_scientist, created_at: value) }
      let(:value) { nil }

      it 'should raise Sequel::InvalidValue' do
        expect { subject }.to raise_error(Sequel::InvalidValue)
      end
    end

    context 'when value of `created_at` property is of String' do
      context 'when the value is not a time\'s representation' do
        let(:params) { attributes_for(:mad_scientist, traits) }
        let(:traits) { { created_at: value } }
        let(:value) { 'not a time\'s representation' }

        it 'should raise Sequel::InvalidValue' do
          expect { subject }.to raise_error(Sequel::InvalidValue)
        end
      end
    end
  end

  describe 'instance of the model' do
    subject(:instance) { create(:mad_scientist) }

    messages = %i[id name madness tries created_at update]
    it { is_expected.to respond_to(*messages) }
  end

  describe '#id' do
    subject(:result) { instance.id }

    describe 'result' do
      subject { result }

      let(:instance) { create(:mad_scientist) }

      it { is_expected.to be_a(String) }
      it { is_expected.to match_uuid_format }
    end
  end

  describe '#name' do
    subject(:result) { instance.name }

    let(:instance) { create(:mad_scientist) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(String) }
    end
  end

  describe '#madness' do
    subject(:result) { instance.madness }

    let(:instance) { create(:mad_scientist) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_an(Integer) }
      it { is_expected.to be >= 0 }
    end
  end

  describe '#tries' do
    subject(:result) { instance.tries }

    let(:instance) { create(:mad_scientist) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_an(Integer) }
      it { is_expected.to be >= 0 }
    end
  end

  describe '#created_at' do
    subject(:result) { instance.created_at }

    let(:instance) { create(:mad_scientist) }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(Time) }
    end
  end

  describe '#update' do
    subject(:result) { instance.update(params) }

    let(:instance) { create(:mad_scientist) }

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

    context 'when `madness` property is present in parameters' do
      let(:params) { { madness: value } }

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

            it 'should set `madness` attribute to the number' do
              expect(instance.madness).to be == number
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

          it 'should set `madness` attribute to the value' do
            expect(instance.madness).to be == value
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

    context 'when `tries` property is present in parameters' do
      let(:params) { { tries: value } }

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

            it 'should set `tries` attribute to the number' do
              expect(instance.tries).to be == number
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

          it 'should set `tries` attribute to the value' do
            expect(instance.tries).to be == value
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
  end
end
