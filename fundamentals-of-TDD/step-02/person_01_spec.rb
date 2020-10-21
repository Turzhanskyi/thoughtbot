# frozen_string_literal: true

require 'rspec/autorun'

# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.
#
class Person
  def initialize(first_name:, last_name:, middle_name: nil)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    squish("#{@first_name} #{@middle_name} #{@last_name}")
  end

  def full_name_with_middle_initial
    squish("#{@first_name} #{@middle_name[0] if @middle_name} #{@last_name}")
  end

  def initials
    squish("#{@first_name[0]} #{@middle_name[0] if @middle_name} #{@last_name[0]}")
  end

  private

  def squish(arg)
    arg.strip.gsub(/\s+/, ' ')
  end
end

RSpec.describe Person do
  let(:person_with_middle_name) do
    Person.new(first_name: 'Jon',
               middle_name: 'Marcus',
               last_name: 'Forest')
  end
  let(:person_without_middle_name) do
    Person.new(first_name: 'Jon',
               last_name: 'Forest')
  end

  describe '#full_name' do
    it 'concatenates first name, middle name, and last name with spaces' do
      expect(person_with_middle_name.full_name).to eq('Jon Marcus Forest')
    end

    it 'does not add extra spaces if middle name is missing' do
      expect(person_without_middle_name.full_name).to eq('Jon Forest')
    end
  end

  describe '#full_name_with_middle_initial' do
    it 'concatenates first name, middle name initial, and last name with spaces' do
      expect(person_with_middle_name.full_name_with_middle_initial).to eq('Jon M Forest')
    end

    it 'does not add extra spaces if middle name is missing' do
      expect(person_without_middle_name.full_name_with_middle_initial).to eq('Jon Forest')
    end
  end

  describe '#initials' do
    it 'concatenates first name initial, middle name initial, and last name initial with spaces' do
      expect(person_with_middle_name.initials).to eq('J M F')
    end

    it 'does not add extra spaces if middle name is missing' do
      expect(person_without_middle_name.initials).to eq('J F')
    end
  end
end
