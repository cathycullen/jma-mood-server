get "/all-coaches" do
  coaches = Coach.all

  content_type :json
  coaches.to_json
end

