class API < Grape::API
  prefix 'api'
  format :json
  
  mount API_First
end