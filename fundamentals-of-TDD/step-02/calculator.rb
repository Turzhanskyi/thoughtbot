# frozen_string_literal: true

require 'rspec/autorun'

class Calculator
  def add(first_number, second_number)
    first_number + second_number
  end

  def factorial(number)
    if number.zero?
      1
    else
      (1..number).reduce(:*)
    end
  end
end

describe Calculator do
  describe '#add' do
    it 'returns the sum of its two arguments' do
      calc = Calculator.new

      expect(calc.add(5, 10)).to eq(15)
    end
  end

  it 'returns 1 when given 0 (0! = 1)' do
    calc = Calculator.new

    expect(calc.factorial(0)).to eq(1)
  end

  it 'returns 120 when given 5 (5! = 120)' do
    calc = Calculator.new

    expect(calc.factorial(5)).to eq(120)
  end
end
