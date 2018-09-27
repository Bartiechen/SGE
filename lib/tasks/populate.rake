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
require './lib/faker/cpf'

namespace :db do
	desc 'Erase and Fill database'
	task populate: :environment do
		[User].each(&:delete_all)

		User.create_with(name: 'Administrador',
										 username: 'admin',
										 registration_number: '0',
										 cpf: '05443678043',
										 admin: true, active: true,
										 password: '123456',
										 support: true).find_or_create_by(email: 'admin@utfpr.edu.br')

		20.times do |i|
			email = Faker::Internet.unique.email
			rn = 1_234_567 + i
			bol = [true, false]
			cpf = Faker::CPF.numeric
			User.create!(name: Faker::Name.name,
									 email: email,
									 username: email.split('@')[0],
									 registration_number: rn,
									 cpf: cpf,
									 admin: bol.sample, active: bol.sample,
									 password: '123456',
									 support: false)

			Client.create(name: Faker::Name.name,
										ra: rn,
										email: email,
										cpf: cpf,
										password: '123456',
										kind: Client.kinds.values.sample)
		end
	end
end
