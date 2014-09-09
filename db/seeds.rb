

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

path=APP_ROOT.join('db/seed_data','moods.txt')
File.open(path, "r") do |f|
  f.each_line do |l|
    MoodState.create(state: l.chomp)
  end
end
