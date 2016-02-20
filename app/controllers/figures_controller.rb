class FiguresController < ApplicationController

  get '/figures' do 
    @figures = Figure.all 
    erb :'figures/index'
  end 
  
  get '/figures/new' do 
 
   erb :'figures/new'
  end 

  post '/figures/new' do
    
    if params[:figure][:name].present?
    @figure = Figure.find_or_create_by(name: params[:figure][:name])
  end 

    if params[:title][:name].present?
    @figure.titles << Title.find_or_create_by(name: params[:title][:name])
  end 

    @landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    @landmark.update(name: @landmark.name, figure_id: @figure.id)
   

    if params[:figure][:landmark_ids].present?
        params[:figure][:landmark_ids].each do |t|
  
        @figure.landmarks << Landmark.find(t.to_i) 
      end 
    end 
    if params[:figure][:title_ids].present?
    params[:figure][:title_ids].each do |t|
      @figure.titles << Title.find(t.to_i)
      end 
    end 

    @figure.save
    redirect '/figures'
  end 

  get '/figures/:id' do 
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end 

  post '/figures/:id' do 
 
    @figure = Figure.find(params[:id])
    @figure.update(name: params[:figure][:name])
    @figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name])
    @landmark.update(name: @landmark.name, figure_id: @figure.id)

    redirect "/figures/#{@figure.id}"
  end 

  get '/figures/:id/edit' do

    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end 

  post '/figures/:id/edit' do 
    
    @figure = Figure.find(params[:id])
    redirect "/figures/#{@figure.id}/edit"
  end

 


end 