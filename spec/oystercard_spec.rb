require "oystercard.rb"

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it "responds to ::DEFAULT_LIMIT" do
    expect(described_class).to be_const_defined(:DEFAULT_LIMIT)
  end

  describe ".balance" do

    context "default balance" do
      it {expect(oystercard.balance).to eq 0}
    end

    context "specify balance of 30" do
      subject(:oystercard) { described_class.new(30) }

      it { expect(oystercard.balance).to eq 30 }

    end
  end

  describe ".top_up" do

    context "topping up card" do

      it "increases the balance" do
        oystercard.top_up(30)
        expect(oystercard.balance).to eq 30
      end

    end

    context "top up limit" do
      default_limit = described_class::DEFAULT_LIMIT
      message = "Cannot top up above £#{default_limit}"
      it "has a limit of 90" do
        expect { oystercard.top_up(default_limit + 1) }.to raise_error(RuntimeError, message)
      end
      it "will not exceed limit of £#{default_limit}" do
        oystercard.top_up(default_limit)
        expect{oystercard.top_up(1)}.to raise_error(RuntimeError, message)
      end

    end

  end

  describe ".deduct" do

    it { is_expected.to respond_to(:deduct).with(1).argument }

  end

end
