namespace :db do
  desc "Collect LIST OF GENERA FOR SPECIMEN IMAGES "
  task collect_list: :environment do
  	require 'nokogiri'
    require 'open-uri'
    collect_list
  end
end

def collect_list

end