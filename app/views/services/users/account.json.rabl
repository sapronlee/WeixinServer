object @account
node(:id) { |o| o.id.to_s }
attributes :name, :en_name, :desc, :token, :identifier, :members_count, :replies_count
node(:api) { |o| api_v1_account_url(@account) }