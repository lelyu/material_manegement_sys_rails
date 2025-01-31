json.extract! material, :id, :name, :location, :quantity, :instructor, :check_in, :check_out, :created_at, :updated_at
json.url material_url(material, format: :json)
