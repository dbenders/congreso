# encoding: UTF-8

require 'csv'
namespace :data do
  desc "import data from files to database"
  task :import => :environment do
    case ENV['type']
    when 'people'
      data = CSV.read(ENV['filename'])
      data.each do |row|
        full_name,province,party,photo = row
        p = Person.find_or_initialize_by_photo_small(photo)
        province = province.titleize; full_name = full_name.titleize
        full_name = full_name.sub('Ñ','ñ').sub('Á','á').sub('É','é').sub('Í','í').sub('Ó','ó').sub('Ú','ú')
        p.province = Province.find_or_create_by_name(province)
        p.party = Party.find_or_create_by_name(party)
        lastname,firstname = full_name.split(',')
        p.firstname = firstname.strip
        p.lastname = lastname.strip
        p.photo_medium = photo.sub('small','medium')
        p.save!
      end
    when 'srt'
      s = BookmarkSet.find_or_create_by_name_and_session_id(ENV['name'],ENV['session'].to_i)
      s.typ = 'manualmatch'
      s.save!
      data = CSV.read(ENV['filename'])
      data.each do |row|
        puts "#{row[0]},#{row[1]}"
        pos = row[0].to_i
        short_name = row[1]
        p = Person.find_by_short_name(short_name)
        b = Bookmark.find_or_initialize_by_bookmark_set_id_and_pos(s.id,pos)
        b.person = p
        b.bookmark_set = s
        b.save!
      end
      s.match_text
    end
  end
end