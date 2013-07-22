class API_First < Grape::API
  version 'v1', cascade: false
  format :json
  formatter :json, Grape::Formatter::Rabl

  resource :accounts do
    desc "create account"
    params do
      requires :identifier,   type: String
      requires :name,         type: String
      requires :en_name,      type: String
      requires :desc,         type: String
      requires :avatar,       type: Object
      requires :qr_code,      type: Object
    end
    post do
      begin
        company = Company.where(identifier: params[:identifier]).first
        if company
          account = company.accounts.new  name: params[:name],
                                       en_name: params[:en_name],
                                          desc: params[:desc],
                                        avatar: params[:avatar],
                                       qr_code: params[:qr_code]

          if account.save
            { result: { account: { token: "#{account.token}" } } }
          else
            error!({ result: { error: "#{account.errors.full_messages.join(',')}" } }, 400)
          end
        end
      rescue
        error!({ reuslt: { error: "Invalid request information" } }, 400)
      end
    end
  end
end