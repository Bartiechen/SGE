namespace :db do
  desc 'Erase and Fill database'
  task populate: :environment do
    [Department, User, DepartmentUser].each(&:destroy_all)

    20.times do
      Department.create!(name: Faker::Address.unique.country, initials: Faker::Address.unique.country_code_long,
                         description: Faker::Lorem.paragraph, local: Faker::LordOfTheRings.location,
                         phone: "(00)0000-0000", email: Faker::Internet.email)
    end

    100.times do
      User.create!(name: Faker::LordOfTheRings.character)
    end

    department_roles = [
        [Department.first, User.first, Role.manager],
        [Department.first, User.last, Role.event_coordinator],
        [Department.first, User.all.sample, Role.module_coordinator],
    ]

    department_roles.each do |department, user, role|
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
