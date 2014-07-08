
c = Coach.create(name: "Jody Michael", email: "cathy@softwareoptions.com", password: "baci1313")
c = Coach.create(name: "Maura Koutoujian", email: "cathy@softwareoptions.com, password: "123")

u1 = User.create(name: "Cathy Cullen", email: "cathy@softwareoptions.com", role:  "admin", password: "123", coach_id: 2)
u2 = User.create(name: "Baci", email: "baci@baci.com", role: "client", password: "123", coach_id: 1)

m = Mood.create(mood: "Happy", internal_external: "event-driven", thoughts: "holiday weekend", energy_level: 4, user_id: 2)
m = Mood.create(mood: "Sad", internal_external: "self-directed", thoughts: "Not going to the beach", energy_level: 2, user_id: 2)

path=APP_ROOT.join('db/seed_data','moods.txt')
File.open(path, "r") do |f|
    f.each_line do |l|
      MoodState.create(state: l.chomp)
    end
  end
