require 'ppzuche'

namespace :ppzuche do
  desc "Download ppzuche data from ppzuche.com"
  task download_data: :environment do
    Ppzuche.load_cars 1..100, start_date: '2014-01-01'
  end
end
