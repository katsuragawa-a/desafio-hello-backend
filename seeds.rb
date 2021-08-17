# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
########
# Limpa o banco de dados
Company.delete_all
Service.delete_all
Project.delete_all
Activity.delete_all

# Cria duas empresas
id = 0

2.times do |company_index|
  token = UidGenerator.generate

  company = Company.create({ name: "Company Test #{company_index}" })
  register_token =
    RegisterToken.create(
      value: token,
      company: company,
      user_permission: 'admin',
      user_job: 'Administrador Prevision',
    )

  email = "admin_#{company_index}@prevision.com.br"
  password = '123qwe'

  user =
    User.create(
      email: email,
      password: password,
      company: register_token.company,
      permission: register_token.user_permission,
    )
  register_token.update_attributes(used_by: user)

  puts '*********************************************'
  puts "    Email: #{email}"
  puts "    Password: #{password}"
  puts '*********************************************'

  5.times do |project_index|
    id += 1

    # Cinco projeto por empresa
    project =
      FactoryBot.create(
        :project,
        company: company,
        name: "Projeto #{project_index}",
      )
    floor = FactoryBot.create(:floor, name: 'Piso 1', project: project)
    service =
      FactoryBot.create(
        :service,
        name: "Serviço #{project_index}",
        color: '#E4045F',
        project: project,
      )
    activity =
      FactoryBot.create(
        :activity,
        project_id: id,
        floor_id: id,
        service_id: id,
        start_at: "2021-07-12 00:00:00",
        created_at: '2021-08-16 16:16:15',
        updated_at: '2021-08-16 16:16:15',
        end_at: '2021-09-17 23:59:59',
        line: 2,
        measurement_unit_id: 3,
        sector_id: id,
      )
  end
end
