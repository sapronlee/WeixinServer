class API_First < Grape::API
  version 'v1', cascade: false
  format :json
  formatter :json, Grape::Formatter::Rabl

  resource :accounts do
    desc "create account"
    params do
      requires :name,    type: String
      requires :en_name, type: String
      requires :desc,    type: String
      requires :avatar,  type: Object
      requires :qr_code, type: Object
    end
    post do
      account = Account.new name: params[:name],
                         en_name: params[:en_name],
                            desc: params[:desc],
                          avatar: params[:avatar],
                         qr_code: params[:qr_code]
      if account.save
        { result: { status: "ok" }, infos: { token: "#{account.token}" } }
      else
        binding.pry
        { result: { status: "no" } }
      end
    end
  end
end