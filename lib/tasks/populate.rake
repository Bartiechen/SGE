namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [Department, User, DepartmentUser].each(&:destroy_all)

    department_list = [
        ["derak", "deraj", "", "p16", "00000000000", "a@k.com"],
        ["deral", "derai", "", "p16", "00000000000", "a@l.com"],
        ["deram", "derah", "", "p16", "00000000000", "a@m.com"],
        ["deran", "derag", "", "p16", "00000000000", "a@n.com"],
        ["derao", "deraf", "", "p16", "00000000000", "a@o.com"],
        ["derap", "derae", "", "p16", "00000000000", "a@p.com"],
        ["deraq", "derad", "", "p16", "00000000000", "a@q.com"],
        ["derar", "derac", "", "p16", "00000000000", "a@r.com"],
        ["deras", "derab", "", "p16", "00000000000", "a@s.com"],
        ["derat", "deraa", "", "p16", "00000000000", "a@t.com"]
    ]

    department_list.each do |name, initials, description, local, phone, email|
      Department.create!(name: name, initials: initials,
                        description: description, local: local, phone: phone, email: email)
    end

    10.times do
      User.create!(name: Faker::Name.name)
    end

    department_role_list = [
        [Department.first, User.first, Role.manager],
        [Department.first, User.last, Role.coordinator]
    ]

    department_role_list.each do |department, user, role|
      DepartmentUser.create(department: department, user: user, role: role)
    end
  end
end