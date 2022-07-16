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

  post "/signin" do
    if params[:email].empty? || params[:password].empty?
      return {statusCode: 400, message: "Please fill in all the fields"}.to_json
    else
      user = User.find_by(email: params[:email])
      if !user
        return {statusCode: 400, message: "Account does not exist, Please signup."}.to_json
      end
      if user && user.password != params[:password]
        return {statusCode: 400, message: "Wrong password/email."}.to_json
      end
      payload = {
        userId: user[:id],
        first_name: user[:first_name],
        last_name: user[:last_name],
        gender: user[:gender],
        email: user[:email],
        password: user[:password]
      }

      token = JWT.encode payload, nil, 'HS256'

      {token: token}.to_json
    end
  end

  post "/signup" do

    if params[:first_name].empty? || params[:last_name].empty? || params[:email].empty? || params[:password].empty?
      return {statusCode: 400, message: "Please fill in all the fields"}.to_json
    elsif User.find_by(email: params[:email])
      return {statusCode: 409, message: "User #{params[:email]} already exists."}.to_json
    elsif params[:password].length < 6
      return {statusCode: 409, message: "Password must be atleast 6 characters or more."}.to_json
    end
    user = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      gender: params[:gender],
      email: params[:email],
      password: params[:password]
    )

    payload = {
      userId: user[:id],
      first_name: user[:first_name],
      last_name: user[:last_name],
      gender: user[:gender],
      email: user[:email],
      password: user[:password]
    }
    token = JWT.encode payload, nil, 'HS256'

    {token: token}.to_json
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

  patch "/tasks/:id" do
    update_task = Project.find(params[:id])
    update_task.update(
      check: params[:check]
    )
    update_task.to_json
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
