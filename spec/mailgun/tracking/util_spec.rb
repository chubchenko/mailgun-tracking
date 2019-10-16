# frozen_string_literal: true

RSpec.describe Mailgun::Tracking::Util do
  describe '.normalize' do
    context 'when the keys of the object are strings' do
      let(:object) do
        { 'a' => 1, 'b' => 2 }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: 1, b: 2)
      end
    end

    context 'when the object has deep string keys' do
      let(:object) do
        { 'a' => { 'b' => { 'c' => 3 } } }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: { b: { c: 3 } })
      end
    end

    context 'when the keys of the object are symbols' do
      let(:object) do
        { a: 1, b: 2 }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(object)
      end
    end

    context 'when an object has deep symbol keys' do
      let(:object) do
        { a: { b: { c: 3 } } }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(object)
      end
    end

    context 'when the keys of the object are mixed' do
      let(:object) do
        { :a => 1, 'b' => 2 }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: 1, b: 2)
      end
    end

    context 'when the keys of the object are integers' do
      let(:object) do
        { 0 => 1, 1 => 2 }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(0 => 1, 1 => 2)
      end
    end

    context 'when an object has deep integer keys' do
      let(:object) do
        { 0 => { 1 => { 2 => 3 } } }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(0 => { 1 => { 2 => 3 } })
      end
    end

    context 'when the key of the object is illegal symbol' do
      let(:object) do
        { [] => 3 }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq([] => 3)
      end
    end

    context 'when an object has deep illegal symbol keys' do
      let(:object) do
        { [] => { [] => 3 } }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq([] => { [] => 3 })
      end
    end

    context 'when the keys of the object are upcase strings' do
      let(:object) do
        { 'A' => 1, 'B' => 2 }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: 1, b: 2)
      end
    end

    context 'when an object has deep upcase string keys' do
      let(:object) do
        { 'A' => { 'B' => { 'C' => 3 } } }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: { b: { c: 3 } })
      end
    end

    context 'when the object value is an array of stringified hashes' do
      let(:object) do
        { 'a' => [{ 'b' => 2 }, { 'c' => 3 }, 4] }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: [{ b: 2 }, { c: 3 }, 4])
      end
    end

    context 'when the object value is an array of symbolized hashes' do
      let(:object) do
        { a: [{ b: 2 }, { c: 3 }, 4] }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(object)
      end
    end

    context 'when the object value is an array of mixed hashes' do
      let(:object) do
        { a: [{ b: 2 }, { 'c' => 3 }, 4] }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: [{ b: 2 }, { c: 3 }, 4])
      end
    end

    context 'when the object value is an array of upcased hashes' do
      let(:object) do
        { 'A' => [{ 'B' => 2 }, { 'C' => 3 }, 4] }
      end

      it 'returns normalized object' do
        expect(described_class.normalize(object)).to eq(a: [{ b: 2 }, { c: 3 }, 4])
      end
    end
  end
end
