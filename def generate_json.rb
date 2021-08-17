def generate_json
  companies =
    Company.all.map do |company|
      projects =
        company.projects.map do |project|
          service =
            Service
              .where(project_id: project.id)
              .map do |service|
                {
                  taskName: service.name,
                  duration:
                    service
                      .activities
                      .reduce(0) do |sum, activity|
                        sum + activity.work_duration
                      end,
                }
              end
          {
            projectName: project.name,
            createdAt: project.created_at,
            service: service,
          }
        end
      {
        companyName: company.name,
        status: company.subscription_plan.status,
        projects: projects,
      }
    end
end

generate_json.to_json
