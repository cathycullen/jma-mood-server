
c = Coach.create(name: "Jody Michael", email: "jody@jodymichael.com", password: "baci1313")
c = Coach.create(name: "Maura Koutoujian", email: "maura@jodymichael.com", password: "123")

u1 = User.create(name: "Cathy Cullen", email: "cathy@softwareoptions.com", role:  "admin", password: "123", coach_id: 2)
u2 = User.create(name: "Baci", email: "baci@baci.com", role: "client", password: "123", coach_id: 1)
