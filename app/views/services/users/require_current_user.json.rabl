object current_user
node(:id) { |o| o.id.to_s }
attributes :email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
if current_user.account.present?
  node(:account_id) { |o| o.account.id.to_s }
end