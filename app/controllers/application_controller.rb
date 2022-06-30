class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    # User.create(first_name: "Wiky api")
    # users = User.all
    # users.to_json
    { message: "Good luck with your project!" }.to_json
  end

  # get "/users" do
  #   user = User.all.order(:created_at)
  #   user.to_json
  # end

  get "/users/:id" do
    proj = User.find(params[:id])
    proj.to_json(include: :projects)
  end

  get "/projects/:id" do
    task = Project.find(params[:id])
    task.to_json(include: :tasks)
  end

  post "/users" do
    person = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      gender: params[:gender],
      email: params[:email],
      password: params[:password]
    )
    person.to_json
  end

  post "/projects" do
    new_project = Project.create(
      project_name: params[:project_name],
      project_scope: params[:project_scope],
      deadline: params[:deadline],
      description: params[:description],
      progress: params[:progress],
      user_id: params[:user_id]
    )
    new_project.to_json
  end

  post "/tasks" do
    new_task = Task.create(
      task_name: params[:task_name],
      check: params[:check],
      project_id: params[:project_id]
    )
    new_task.to_json
  end

  patch "/users/:id" do
    update_user = User.find(params[:id])
    update_user.update(
      password: params[:password]
    )
    update_user.to_json
  end

  patch "/projects/:id" do
    update_project = Project.find(params[:id])
    update_project.update(
      project_name: params[:project_name],
      project_scope: params[:project_scope],
      deadline: params[:deadline],
      description: params[:description],
      progress: params[:progress]
    )
    update_project.to_json
  end

  delete "/projects/:id" do
    project = Project.find(params[:id])
    project.destroy
    project.to_json
  end

  delete "/tasks/:id" do
    task = Task.find(params[:id])
    task.destroy
    task.to_json
  end


end
