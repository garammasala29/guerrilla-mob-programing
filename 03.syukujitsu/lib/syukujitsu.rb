require 'date'
require 'csv'

class Syukujitsu
  DEFAULT_CSV_PATH = File::expand_path('../sourse/syukujitsu.csv', __dir__)

  def self.parse
    self.new.parse
  end

  def self.write
    self.new.write
  end

  def parse
    csv_rows = read_file
    convert_to_hash(csv_rows)
  end

  def read_file(csv: DEFAULT_CSV_PATH)
    CSV.read(csv, encoding: 'CP932:UTF-8')
  end

  def convert_to_hash(csv_rows)
    syukujitsu = {}
    csv_rows[2..].transpose.each_slice(2) do |keys, values|
      dates = keys.compact.map { |key| Date.parse(key) }
      syukujitsu[dates.first.year] = dates.zip(values.compact).to_h
    end
    syukujitsu
  end

  def write
    correct_csv_path = File::expand_path('../sourse/correct_syukujitsu.csv', __dir__)

    CSV.open(correct_csv_path, "w", encoding: 'CP932') do |csv|
      parse.each_value do |value|
        value.each do |k, v|
          csv << [k.strftime("%Y/%-m/%-d"),v]
        end
      end
    end
  end
end
