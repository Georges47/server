Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://server-front-1.herokuapp.com' #'*'

    resource '*', headers: :any, methods: [:get, :post]
  end
end