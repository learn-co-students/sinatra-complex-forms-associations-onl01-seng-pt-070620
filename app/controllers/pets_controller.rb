class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    # @owners = Owner.all
    # using Owner.all.each in form instead
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    # how to create association pet and owner?
    if !params["owner"]["name"].empty?
      # method 1: build method to associate
      # @owner = Owner.create(params[:pet][:owner]["name"])
      # @pet.build.owner = @owner
      # method 2: direct assigning
      @pet.owner = Owner.create(name: params["owner"]["name"])
    else 
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end 
      @pet.save
      redirect to "pets/#{@pet.id}"
    end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do 
    #binding.pry
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params["pet"])
   
    # if !params["pet"].keys.include("owner_id")
    #   params["pet"]["owner_id"] = []
    # end 

      if !params["owner"]["name"].empty?
        @pet.owner = Owner.create(name: params["owner"]["name"])
      else 
        @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
      end 
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end