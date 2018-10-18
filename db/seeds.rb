roles = [
    ["Chefe de Departamento", :manager],
    ["Coordenador de Evento", :event_coordinator],
    ["Coordenador de Módulo", :module_coordinator],
    ["Membro do Departamento", :member]
]

roles.each do |name, identifier|
  Role.find_or_create_by!(name: name, identifier: identifier)
end
