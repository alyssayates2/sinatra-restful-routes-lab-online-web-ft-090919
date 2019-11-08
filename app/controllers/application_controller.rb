class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
  @recipes = Recipe.all

  erb :index
  end

  get '/recipes/new' do
    erb :recipe
  end

  post "/recipes" do
  recipe = Recipe.new(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])

  if params[:name] == "" || params[:ingredients] == "" || params[:cook_time] == ""
    redirect "/failure"
  else
    recipe.save
    redirect "/recipes/#{recipe.id}"
    end
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])

    erb :edit
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  patch '/recipes/:id' do
    erb :edit
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect "/recipes"
  end

end
