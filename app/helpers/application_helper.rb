module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end
end

def fetch_location

    location_hash = {}
    output = JSON.parse(open('http://ipinfo.io').read)

    location_hash[:city] = output["city"]
    location_hash[:zip_code] = output["postal"]
    location_hash.to_s
    @current_location = location_hash[:city]
    @current_location
    # redirect '/users/home'
end

def fetched_location
    @location
end
