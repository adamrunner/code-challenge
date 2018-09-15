require 'rspec'
require 'rspec/expectations'
require './application'

describe Application do
  subject { Application.new }
  describe "#new_transaction" do
    it "adds a new state onto the stack of states" do
      expect { subject.new_transaction }.to change{subject.states.count}.by(1)
    end
  end

  describe "#commit_transaction" do
    context "when the transaction is commited" do
      it "should return false" do
        expect(subject.commit_transaction).to eq(false)
      end
    end

    context "when the transaction is not committed" do
      before { subject.new_transaction }
      it "should return true" do
        expect(subject.commit_transaction).to eq(true)
      end

      it "should set the persisted attribute on the state object" do
        subject.commit_transaction
        expect(subject.current_state.persisted).to eq(true)
      end
    end
  end

  describe "#rollback_transaction" do
    context "when there is a non-persisted transaction to rollback" do
      before do
        subject.new_transaction
        subject.set_value("blah", "BLEH")
      end
      it "changes the current state of the application to the previous state" do
        expect { subject.rollback_transaction }.to change{ subject.current_state.data }.from({:foo=>"bar", "blah"=>"BLEH"}).to({:foo => "bar"})
      end
    end

    context "when there is not a non-persisted transaction to rollback" do
      it "returns false" do
        expect(subject.rollback_transaction).to eq(false)
      end

      it "does not change the current state of the application" do
        expect { subject.rollback_transaction }.not_to change{ subject.current_state.data }
      end
    end
  end
end