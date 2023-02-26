require 'date'
require 'csv'

class Syukujitsu
  DEFAULT_CSV_PATH = File::expand_path('../sourse/syukujitsu.csv', __dir__)

  def self.parse
    self.new.parse
  end

  def parse(csv: DEFAULT_CSV_PATH)
    csv_rows = CSV.read(csv, encoding: 'CP932:UTF-8')
    syukujitsu_hash = {}
    csv_rows[2..].transpose.each_slice(2) do |keys, values|
      dates = keys.compact.map { |key| Date.parse(key) }
      syukujitsu_hash[dates.first.year] = dates.zip(values.compact).to_h
    end
    syukujitsu_hash
  end

end
