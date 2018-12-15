require 'spec_helper'

describe Icodi do
  context "given a string" do
    subject { described_class.new "thanks victor" }
    
    it "generates consistent svg" do
      expect(subject.to_s).to match_fixture 'render1'
    end
  end
end
