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

class Person
  def initialize(first_name:, last_name:, middle_name: nil)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  # implement your behavior here

  def full_name
    [@first_name, @middle_name, @last_name].join(' ').squeeze(' ')
  end

  def full_name_with_middle_initial
    [@first_name, @middle_name ? @middle_name.chr.concat('.') : '', @last_name].join(' ').squeeze(' ')
  end

  def initials
    [@first_name.chr.concat('.'), @middle_name ? @middle_name.chr.concat('.') : '', @last_name.chr.concat('.')].join(' ').squeeze(' ')
  end
end

RSpec.describe Person do
  describe '#full_name' do
    it 'concatenates first name, middle name, and last name with spaces' do
      p = Person.new(first_name: 'Mitchell', middle_name: 'Seth', last_name: 'Gould')

      expect(p.full_name).to eq('Mitchell Seth Gould')
    end
    it 'does not add extra spaces if middle name is missing' do
      p = Person.new(first_name: 'Mitchell', last_name: 'Gould')
      expect(p.full_name).to eq('Mitchell Gould')
    end
  end

  describe '#full_name_with_middle_initial' do
    it 'concatenates first name, middle initial, and last name with spaces' do
      p = Person.new(first_name: 'Mitchell', middle_name: 'Seth', last_name: 'Gould')
      expect(p.full_name_with_middle_initial).to eq('Mitchell S. Gould')
    end
    it 'concatenates first name, and last name with no extra spaces if no middle name' do
      p = Person.new(first_name: 'Mitchell', last_name: 'Gould')
      expect(p.full_name_with_middle_initial).to eq('Mitchell Gould')
    end
  end

  describe '#initials' do
    it 'creates initals from first name, middle name, and last name and concatenates them with spaces' do
      p = Person.new(first_name: 'Mitchell', middle_name: 'Seth', last_name: 'Gould')
      expect(p.full_name_with_middle_initial).to eq('Mitchell S. Gould')
    end

    it 'creates initals from first namevand last name and concatenates them without extra spaces' do
      p = Person.new(first_name: 'Mitchell', last_name: 'Gould')
      expect(p.initials).to eq('M. G.')
    end
  end
end
