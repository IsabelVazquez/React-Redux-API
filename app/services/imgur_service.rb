require 'faraday'

class ImgurService
  def importImages(id)
    @resp = Faraday.get 'https://api.imgur.com/3/image/' + id do |req|
      req.headers['Authorization'] = "Client-ID #{ENV["CLIENT_ID"]}"
    end
    json = JSON.parse(@resp.body)
    json["data"]["cover"] = json["data"]["id"]
    json["data"]["upvotes"] = Image.find_by(imgur_id: json["data"]["id"]).upvotes
    return json["data"]
  end

  def importGallery(section)
    @resp = Faraday.get 'https://api.imgur.com/3/gallery/t/' + section do |req|
      req.headers['Authorization'] = "Client-ID #{ENV["CLIENT_ID"]}"
    end
    json = JSON.parse(@resp.body)
    return json["data"]
  end
end
