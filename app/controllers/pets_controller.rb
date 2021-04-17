class PetsController < ApplicationController
  protect_from_forgery except: [:upload_pet_photos]

  before_action :authenticate_user!, except: [:show]
  before_action :set_pet, except: [:new, :create]
  before_action :not_auth, only: [:update, :edit, :upload_pet_photos, :delete_pet_photos]

 # Instantiate is get method - it just gets the information of the fields. Get get ready!
  def new
    @pet = current_user.pets.build
    @categories = Category.all
  end

  # Creating is a Post method it literally save into the fields of the database.
  def create
    @pet = current_user.pets.build(pet_params)
    if @pet.save
      @pet.costs.create(Cost.cost_types.values.map { |i| {cost_type: i} })
      redirect_to edit_pet_path(@pet), notice: "Great please continue filling out the remaining fileds"
    else
      flash[:alert] = "Ooops something does not seems right."
      render :new
    end
  end

  def edit
    @categories = Category.all
  end


  def update
    if @pet.update(pet_params)

      pet_params[:costs_attributes].each do |k, v|
        if @pet.has_one_transport_cost && v[:cost_type] != Cost.cost_types.key(0)
          flash[:notice] = "Great...saved!"
        else
          if v[:title].blank? || v[:description].blank? || v[:transport_time].blank? || v[:cost].blank?
            return redirect_to request.referer, flash: {error: "Please continue to fill out all transporation fields. They are required."}
          end
        end
      end

      flash[:notice] = "Saved successfully."
    else
      flash[:alert] = "Error, nothing has been saved."
    end
    redirect_back(fallback_location: request.referer)
  end


  def show
  end

  def upload_pet_photos
    @pet.pet_photos.attach(params[:file])
    render json: {success: true}
  end

  def delete_pet_photos
    @img = ActiveStorage::Attachment.find(params[:pet_photo_id])
    @img.purge
    redirect_to edit_pet_path(@pet), notice: 'Removed successfully.'
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def not_auth
    redirect_to root_path alert: "I don't think you have perrmision to do this" unless current_user.id == @pet.user_id
  end

  private
  def pet_params
    params.require(:pet).permit(:title, :pet_description, :active, :is_spayed, :has_one_transport_cost, :video, :category_id,
                                :is_dog_friendly, :is_cat_friendly, :is_people_friendly, :is_dominant, :is_shows_past_abuse, 
                                :is_barks_alot, :weight, :age, :michrochip, costs_attributes: [:id, :title, :description, 
                                :transport_time, :cost, :cost_type])
  end
end
