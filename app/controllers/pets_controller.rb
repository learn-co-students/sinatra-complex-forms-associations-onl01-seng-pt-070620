class PetsController < ApplicationController

  get '/pets' do
    @pet = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    # how to create association pet and owner?
    if !params[:pet][:owner]["name"].empty?
      # method 1: build method to associate
      @owner = Owner.create(params[:pet][:owner]["name"])
      @pet.build.owner = @owner
      # method 2: direct assigning
      @owner.owner = Owner.create(params[:pet][:owner]["name"])
      @pet.save
    end 
   
      redirect to "pets/#{@pet.id}"
    end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owner = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do 
    if !params[:pet].keys.include("owner_id")
      params[:pet]["owner_id"] = []
    end 

    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end 
    redirect to "pets/#{@pet.id}"
  end
end