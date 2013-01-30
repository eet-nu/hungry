require 'spec_helper'

describe Hungry::Review do
  # describe '.find' do
  #   context 'with a valid ID' do
  #     use_vcr_cassette
  #
  #     subject { Hungry::Review.find(54863) }
  #
  #     it 'finds a review' do
  #       subject.should be_a Hungry::Review
  #     end
  #
  #     it "sets the review's attributes" do
  #       subject.body.should include "vriendelijkheid van het personeel"
  #     end
  #   end
  #
  #   context 'with an invalid ID' do
  #     use_vcr_cassette
  #
  #     subject { Hungry::Review.find(1024 ** 4) }
  #
  #     it 'returns nil' do
  #       subject.should be_nil
  #     end
  #   end
  # end
  #
  # describe '.latest' do
  #   use_vcr_cassette
  #
  #   it 'finds reviews' do
  #     Hungry::Review.latest[0].should be_a Hungry::Review
  #   end
  # end
  
  describe '#initialize' do
    it "sets the review's attributes" do
      venue = Hungry::Review.new body: 'Awesome'
      venue.body.should == 'Awesome'
    end
  end
end
