require 'spec_helper'

describe Icodi do
  context "given a string" do
    subject { described_class.new "thanks victor", jitter: 0.3 }
    
    it "generates consistent svg" do
      expect(subject.to_s).to match_fixture 'render1'
    end
  end
end
