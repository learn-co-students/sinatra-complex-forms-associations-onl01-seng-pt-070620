class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  # get '/owners/new' do 
  #   @pets = Pet.all
  #   erb :'/owners/new'
  # end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      # binding.pry
      @pet.owner = Owner.create(name: params[:owner][:name])
      # binding.pry
    end
    @pet.save
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  # post '/owners' do
  #   @owner = Owner.create(params[:owner])
  #   if !params["pet"]["name"].empty?
  #     @owner.pets << Pet.create(name: params["pet"]["name"])
  #   end
  #   redirect "owners/#{@owner.id}"
  # end

  # get '/owners/:id/edit' do 
  #   @owner = Owner.find(params[:id])
  #   @pets = Pet.all
  #   erb :'/owners/edit'
  # end

  get '/pets/:id' do
    # binding.pry 
    @pet = Pet.find(params[:id])
    # binding.pry
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end

end