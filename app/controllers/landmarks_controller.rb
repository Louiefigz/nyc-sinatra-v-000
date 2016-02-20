class LandmarksController < ApplicationController

  get '/landmarks' do 
    @landmarks = Landmark.all 
    erb :'landmarks/index'
  end


  get '/landmarks/new' do 
    erb :'landmarks/new'
  end 

  post '/landmarks/new' do 
    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect '/landmarks'
  end

  get '/landmarks/:id' do 
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end 

  post '/landmarks/:id' do 
    @landmark = Landmark.find(params[:id])
    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect "/landmarks/#{@landmark.id}"
  end 

  post '/landmarks/:id/edit' do 
    @landmark = Landmark.find(params[:id])
    redirect "/landmarks/#{@landmark.id}/edit"
  end 

  get '/landmarks/:id/edit' do 
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end 

end
