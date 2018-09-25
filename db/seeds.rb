User.create_with(name: 'Administrador',
                 username: 'admin',
                 registration_number: '0',
                 cpf: '05443678043',
                 admin: true, active: true,
                 password: '123456',
                 support: true).find_or_create_by(email: 'admin@utfpr.edu.br')

role_list.each do |name, flag|
  Role.create(name: name, flag: flag)
end

department_role_list = [
    [Department.first, User.first, Role.manager],
    [Department.first, User.last, Role.coordinator]
]

department_role_list.each do |department, user, role|
  DepartmentRole.create(department: department, user: user, role: role)
end