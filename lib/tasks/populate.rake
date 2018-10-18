namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [Department, User, DepartmentUser].each(&:destroy_all)

    20.times do
      name = Faker::Address.unique.country
      Department.create!(name: name, initials: Faker::Address.unique.country_code_long,
                         description: Faker::Lorem.paragraph, local: Faker::LordOfTheRings.location,
                         phone: "(00)0000-0000", email: "#{name}@utfpr.edu.br")
    end

    100.times do
      User.create!(name: Faker::LordOfTheRings.character)
    end

    department_roles = [
        [Department.first, User.first, Role.manager],
        [Department.first, User.last, Role.event_coordinator],
        [Department.first, User.find(User.all.sample), Role.module_coordinator],
    ]

    department_roles.each do |department, user, role|
      DepartmentUser.create(department: department, user: user, role: role)
    end
  end
end