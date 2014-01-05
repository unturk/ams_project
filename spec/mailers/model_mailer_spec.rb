require "spec_helper"

describe ModelMailer do
  describe "new_request" do
    let(:mail) { ModelMailer.new_request }

    it "renders the headers" do
      mail.subject.should eq("New request")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
