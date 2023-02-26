# frozen_string_literal: true

require_relative '../lib/syukujitsu'
require 'date'
require 'byebug'

RSpec.describe Syukujitsu do
  example "取り込んだCSVデータをhash化できる" do
    hash =
      {
        2022 => {
          Date.parse('2022/01/01') => '元日',
          Date.parse('2022/01/10') => '成人の日',
          Date.parse('2022/02/11') => '建国記念の日',
          Date.parse('2022/02/23') => '天皇誕生日',
          Date.parse('2022/03/21') => '春分の日',
          Date.parse('2022/04/29') => '昭和の日',
          Date.parse('2022/05/03') => '憲法記念日',
          Date.parse('2022/05/04') => 'みどりの日',
          Date.parse('2022/05/05') => 'こどもの日',
          Date.parse('2022/07/18') => '海の日',
          Date.parse('2022/08/11') => '山の日',
          Date.parse('2022/09/19') => '敬老の日',
          Date.parse('2022/09/23') => '秋分の日',
          Date.parse('2022/10/10') => 'スポーツの日',
          Date.parse('2022/11/03') => '文化の日',
          Date.parse('2022/11/23') => '勤労感謝の日',
        },
        2023 => {
          Date.parse('2023/01/01') => '元日',
          Date.parse('2023/01/02') => '休日',
          Date.parse('2023/01/09') => '成人の日',
          Date.parse('2023/02/11') => '建国記念の日',
          Date.parse('2023/02/23') => '天皇誕生日',
          Date.parse('2023/03/21') => '春分の日',
          Date.parse('2023/04/29') => '昭和の日',
          Date.parse('2023/05/03') => '憲法記念日',
          Date.parse('2023/05/04') => 'みどりの日',
          Date.parse('2023/05/05') => 'こどもの日',
          Date.parse('2023/07/17') => '海の日',
          Date.parse('2023/08/11') => '山の日',
          Date.parse('2023/09/18') => '敬老の日',
          Date.parse('2023/09/23') => '秋分の日',
          Date.parse('2023/10/09') => 'スポーツの日',
          Date.parse('2023/11/03') => '文化の日',
          Date.parse('2023/11/23') => '勤労感謝の日',
        },
        2024 => {
          Date.parse('2024/01/01') => '元日',
          Date.parse('2024/01/08') => '成人の日',
          Date.parse('2024/02/11') => '建国記念の日',
          Date.parse('2024/02/12') => '休日',
          Date.parse('2024/02/23') => '天皇誕生日',
          Date.parse('2024/03/20') => '春分の日',
          Date.parse('2024/04/29') => '昭和の日',
          Date.parse('2024/05/03') => '憲法記念日',
          Date.parse('2024/05/04') => 'みどりの日',
          Date.parse('2024/05/05') => 'こどもの日',
          Date.parse('2024/05/06') => '休日',
          Date.parse('2024/07/15') => '海の日',
          Date.parse('2024/08/11') => '山の日',
          Date.parse('2024/08/12') => '休日',
          Date.parse('2024/09/16') => '敬老の日',
          Date.parse('2024/09/22') => '秋分の日',
          Date.parse('2024/09/23') => '休日',
          Date.parse('2024/10/14') => 'スポーツの日',
          Date.parse('2024/11/03') => '文化の日',
          Date.parse('2024/11/04') => '休日',
          Date.parse('2024/11/23') => '勤労感謝の日',
        },
      }
    expect(Syukujitsu.parse).to eq hash
  end

  example 'hash化したデータをCSVに書き込むことができる' do
    Syukujitsu.write
    collect_syukujitsu_path = File::expand_path('../sourse/collect_syukujitsu.csv', __dir__)
    collect_syukujitsu = CSV.read(collect_syukujitsu_path, encoding: 'CP932:UTF-8')
    answer_syukujitsu_path = File::expand_path('../sourse/answer_syukujitsu.csv', __dir__)
    answer_syukujitsu = CSV.read(collect_syukujitsu_path, encoding: 'CP932:UTF-8')
    expect(collect_syukujitsu).to eq answer_syukujitsu
  end
end
