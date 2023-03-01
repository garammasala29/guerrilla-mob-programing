require 'date'
require 'csv'

class Syukujitsu
  DEFAULT_CSV_PATH = File::expand_path('../sourse/syukujitsu.csv', __dir__)

  def self.parse(*)
    self.new.parse
  end

  def self.write
    self.new.write
  end

  def parse(csv = DEFAULT_CSV_PATH)
    csv_rows = read_file(csv)
    convert_to_hash(csv_rows)
  end

  def read_file(csv)
    CSV.read(csv, encoding: 'CP932:UTF-8')
  end

  def convert_to_hash(csv_rows)
    syukujitsu = {}
    csv_rows[2..].transpose.each_slice(2) do |dates, names|
      dates = dates.compact.map { |date| Date.parse(date) }
      syukujitsu[dates.first.year] = dates.zip(names.compact).to_h
    end
    syukujitsu
  end

  def write
    correct_csv_path = File::expand_path('../sourse/correct_syukujitsu.csv', __dir__)

    CSV.open(correct_csv_path, "w", encoding: 'CP932') do |csv|
      parse.each_value do |annual_syukujitsu|
        annual_syukujitsu.each do |date, name|
          csv << [date.strftime("%Y/%-m/%-d"),name]
        end
      end
    end
  end
end
