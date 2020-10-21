# frozen_string_literal: true

require 'rspec'

require_relative 'quantity'
require_relative 'unit_converter'
require_relative 'unit_database'

describe 'integrating the database with the converter' do
  def database_filename
    'test_db.sqlite'
  end

  around do |example|
    example.run
  ensure
    file.delete(database_filename)
  end

  def create_and_populate_database(filename = database_filename)
    db = UnitDatabase.new(filename)
    db.clear_conversions
    db.add_conversion(canonical_unit: :liter, unit: :cup, ratio: 4.22675)
    db.add_conversion(canonical_unit: :liter, unit: :liter, ratio: 1)
    db.add_conversion(canonical_unit: :liter, unit: :pint, ratio: 2.11338)
    db.add_conversion(canonical_unit: :gram, unit: :gram, ratio: 1)
    db.add_conversion(canonical_unit: :gram, unit: :kilogram, ratio: 1000)
    db
  end

  it 'converts between cups and pints through liters' do
    db = create_and_populate_database
    cups = Quantity.new(amount: 2, unit: :cup)
    converter = UnitConverter.new(cups, :pint, db)

    result = converter.convert

    expect(result.amount).to be_within(0.001).of(1)
    expect(result.unit).to eq(:pint)
  end
end
