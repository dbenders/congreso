class Person < ActiveRecord::Base
  attr_accessible :username, :facebook, :firstname, :lastname, :photo_medium, :photo_small, :twitter, :website, :wikipedia
  belongs_to :province
  belongs_to :party
  belongs_to :chamber
  has_many :text_bookmarks


  def fullname
  	"#{lastname}, #{firstname}"
  end

  def to_param
    username || "#{lastname.downcase}_#{firstname.downcase}"
  end

  def to_s
  	fullname
  end

  def match(name)
    lastname == name
  end

  def self.find_by_short_name(short_name)
  	if not short_name.include?('(')
	  	Person.find_by_lastname(short_name.strip.titleize)
	  else
	  	lastname,p = short_name.split('(')
	  	initials = p.scan(/(.)\./).collect {|x| x[0]} 
	  	candidates = Person.find_all_by_lastname(lastname.strip.titleize)
	  	candidates.find do |cand|
	  		ini = cand.firstname.split().collect { |x| x[0]}
	  		if ini == initials
	  			return cand
	  		end
	  	end
	  	puts "Not found: '#{short_name}'"
	  end

  end
end
