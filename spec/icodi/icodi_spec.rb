require 'spec_helper'

describe Icodi do
  subject(:icodi) { described_class.new text, options }

  let(:text) { 'some text' }
  let(:options) { {} }

  describe '#so_s' do
    subject(:output) { icodi.to_s }

    context 'with a text input' do
      it 'returns a consistent svg' do
        expect(output).to match_approval 'text'
      end
    end

    context 'with all the options' do
      let(:options) do
        {
          id: 'test', pixels: 4, mirror: :both, color: '#faa', density: 0.6,
          stroke: 3, jitter: 0.5, background: 'black'
        }
      end

      it 'returns valid svg' do
        expect(output).to match_approval 'options'
      end
    end

    context 'with options but without text' do
      subject(:icodi) { described_class.new options }

      let(:options) { { pixels: 4 } }

      it 'returns valid svg' do
        expect(output).to be_a String
      end
    end

    context 'with mirror: :none' do
      let(:options) { { mirror: :none } }

      it 'returns valid svg' do
        expect(output).to match_approval 'mirror-none'
      end
    end

    context 'with mirror: :y + jitter' do
      let(:options) { { pixels: 3, mirror: :y, jitter: 0.9 } }
      let(:text) { 'longer text' }

      it 'returns valid svg' do
        expect(output).to match_approval 'mirror-y-jitter'
      end
    end

    context 'with mirror: :x + jitter' do
      let(:options) { { pixels: 3, mirror: :x, jitter: 0.9 } }
      let(:text) { 'longer text' }

      it 'returns valid svg' do
        expect(output).to match_approval 'mirror-x-jitter'
      end
    end
  end

  describe 'options' do
    describe 'template' do

      it 'defaults to default' do
        expect(subject.template).to eq :default
      end

      context 'when set to html' do
        let(:options) { { template: :html} }

        it 'uses html as template' do
          expect(subject.template).to eq :html
        end
      end

    end
  end
end
