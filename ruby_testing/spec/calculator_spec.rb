require './lib/calculator'

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe "#subtract" do
    it "returns the first number subtracted by the second number" do
      calculator = Calculator.new
      expect(calculator.subtract(6, 9)).to eql(-3)
    end

    it "returns the first number subtracted by subsequent numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(72, 1, 2)).to eql(69)
    end
  end

  describe "#multiply" do
    it "returns the multiplication of two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(6, 9)).to eql(54)
    end

    it "returns the multiplication of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(23, 1, 3)).to eql(69)
    end
  end

  describe "#divide" do
    it "returns the first number divided by the second number" do
      calculator = Calculator.new
      expect(calculator.divide(18, 9)).to eql(2)
    end
  end
end