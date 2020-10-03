class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet]) unless !params[:pet][:owner_id]
    if !params[:pet][:owner_id]
      @owner = Owner.create(params[:owner])
      @pet = Pet.create(params[:pet])
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])

    if params[:owner_name].empty?
      @pet.update(owner: Owner.find_by(params[:owner]))
    else
      @pet.update(owner: Owner.find_or_create_by(name: params[:owner_name]))
    end

    redirect to "pets/#{@pet.id}"
  end
end