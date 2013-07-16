class API_First < Grape::API
  version 'v1', cascade: false
  format :json
  formatter :json, Grape::Formatter::Rabl
  
end