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
        province = province.titleize; party = party.titleize; full_name = full_name.titleize
        p.province = Province.find_or_create_by_name(province)
        p.party = Party.find_or_create_by_name(party)
        lastname,firstname = full_name.split(',')
        p.firstname = firstname.strip
        p.lastname = lastname.strip
        p.save!
      end
    when 'srt'
      data = CSV.read(ENV['filename'])
      data.each do |row|
        puts "#{row[0]},#{row[1]}"
        pos = row[0].to_i
        short_name = row[1]
        session = Session.find(ENV['session'].to_i)
        p = Person.find_by_short_name(short_name)
        b = Bookmark.find_or_initialize_by_session_id_and_pos(session.id,pos)
        b.person = p
        b.typ = 'manualmatch'
        b.save!
      end
    end
  end
end