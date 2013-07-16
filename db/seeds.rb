# encoding: utf-8

if Rails.env.test? or Rails.env.development?
  User.create realname: '毛毛', email: 'sapronlee@gmail.com', password: '123123', password_confirmation: '123123'
end

if Rails.env.production?
end