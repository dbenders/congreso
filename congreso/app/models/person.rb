class Person < ActiveRecord::Base
  attr_accessible :facebook, :firstname, :lastname, :photo_medium, :photo_small, :twitter, :website, :wikipedia
  belongs_to :province
  belongs_to :party
  has_many :bookmarks

  def to_s
  	"#{lastname}, #{firstname}"
  end

  def self.find_by_short_name(short_name)
  	if not short_name.include?('(')
  		puts short_name.strip.titleize
	  	Person.find_by_lastname(short_name.strip.titleize)
	  else
	  	require 'debugger'; debugger
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
