class Api::V1::ImagesController < ApplicationController
  def index
    images = User.find(image_params[:user_id]).images
    imgur_service = ImgurService.new
    if images.blank?
      render json: {errors: "No pictures found"}, status: 401
    else
      imgur_images = images.pluck(:imgur_id).uniq.collect { |image| imgur_service.importImages(image) }

      response = {
        user_images: imgur_images
      }
      render json: response, status: 201
    end
  end

  def votes
    image = Image.find_by(imgur_id: image_params[:imgur_id])
    image.upvotes += 1
    imgur_service = ImgurService.new
    if image.save
      updateImageInfo = imgur_service.importImages(image_params[:imgur_id])
      
      response = {
        updatedInfo: updateImageInfo
      }
      render json: response, status: 201
    end
  end

  def galleries
    imgur_service = ImgurService.new
    imgur_galleries = imgur_service.importGallery(gallery_params[:section])
    response = {
      galleries: imgur_galleries
    }
    render json: response, status: 201
  end

  def create
    image = Image.new(image_params)
    if image.save
      response = {
        id: image.id,
        imgur_id: image.imgur_id,
        user_id: image.user_id,
        success: true
      }
      render json: response, status: 201
    else
      render json: {error: image.errors.full_messages.join(',')}, status: 401
    end
  end

  private

  def image_params
    params.require(:image).permit(:imgur_id, :user_id)
  end

  def gallery_params
    params.permit(:section)
  end
end
