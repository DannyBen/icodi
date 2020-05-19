require 'spec_helper'

describe Icodi do
  let(:text) { "some text" }
  let(:options) { {} }  
  subject { described_class.new text, options }

  context "given a string" do
    it "generates consistent svg" do
      expect(subject.to_s).to match_approval 'render1'
    end
  end

  context "given all the options" do
    let(:options) {{ 
      id: 'test', pixels: 4, mirror: :both, color: '#faa', density: 0.6, 
      stroke: 3, jitter: 0.5, background: 'black' 
    }}
    
    it "works" do
      expect(subject.to_s).to match_approval 'render2'
    end
  end
end
