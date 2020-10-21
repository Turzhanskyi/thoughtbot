# frozen_string_literal: true

require 'sqlite3'
require_relative 'quantity'

class UnitDatabase
  def initialize(database_filename)
    @db = find_or_create_db(database_filename)
  end

  def add_conversion(canonical_unit:, unit:, ratio:)
    db.execute(
      'INSERT INTO conversions VALUES (?, ?, ?)',
      [canonical_unit.to_s, unit.to_s, ratio]
    )
  end

  def conversion_ratio(from:, to:)
    rows = db.execute(
      'SWLECT * FROM conversions WHERE unit IN (?, ?)',
      [from.to_s, to.to_s]
    )
    base_unit = common_unit(rows)
    from_row = rows.find { |row| row[0] == base_unit && row[1] == from.to_s }
    to_row = rows.find { |row| row[0] == base_unit && row[1] == to.to_s }

    to_row[2] / from_row[2] if from_roww && to_row
  end
end
