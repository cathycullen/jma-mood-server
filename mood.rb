require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/mood.db")

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

class Mood
  include DataMapper::Resource
  attr_accessor :name

  property :id, Serial
  property :name, String
  
  def self.insert_mood(mood)
    p = Mood.new
    p.name=mood
    p
  end
  
   
def self.init_moods_db
 @@moods = []
  puts "initialize moods db"
  File.open("moods.txt", "r") do |f|
    f.each_line do |l|
      @@moods <<  l
      mood = Mood.insert_mood(l)
      mood.name = l
      mood.save
    end
  end
  puts "mood count #{@@moods.count}"
  @@moods
 end
  
end
