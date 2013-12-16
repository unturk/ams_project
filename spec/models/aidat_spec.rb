require 'spec_helper'

describe Aidat do

  before do
    @aidat = Aidat.new(daire:"1", year:"2013", month:"Ocak")
  end

  subject { @aidat }

  it { should respond_to(:daire) }
  it { should respond_to(:year) }
  it { should respond_to(:month) }

  it { should be_valid }


  describe "when aidat is already paid" do
    before do
      aidat_with_same_month_year = @aidat.dup
      aidat_with_same_month_year.save
    end

    it { should_not be_valid }
  end

end