require 'date'
require 'csv'

class Syukujitsu
  DEFAULT_CSV_PATH = File::expand_path('../sourse/syukujitsu.csv', __dir__)

  def self.parse
    self.new.parse
  end

  def parse(csv: DEFAULT_CSV_PATH)
    CSV.read(csv)
  end

end
