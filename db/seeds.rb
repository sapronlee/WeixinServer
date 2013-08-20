# encoding: utf-8

if Rails.env.test? or Rails.env.development?
  # Admin User
  User.find_or_create_by realname: '毛毛', email: 'sapronlee@gmail.com', password: '123123', password_confirmation: '123123'
  u = User.find_or_create_by realname: 'user', email: 'user@1trip.com', password: '123123', password_confirmation: '123123'
  AdminUser.find_or_create_by realname: 'admin', email: 'admin@1trip.com', password: '123123', password_confirmation: '123123'
  # Test Replies Data
  Reply.find_or_create_by number: 1, name: '武侯祠', title: '武侯祠', content: '这里是武侯祠'
  Reply.find_or_create_by number: 2, name: '杜甫草堂', title: '杜甫草堂', content: '这里是杜甫草堂'
  Reply.find_or_create_by number: 3, name: '青城山', title: '青城山', content: '这里是青城山'
  Reply.find_or_create_by number: 4, name: '峨眉山', title: '峨眉山', content: '这里是峨眉山'

  a = Account.create name: '四川旅游局', en_name: 'en_四川旅游局', user_id: u.id
  member = a.members.create open_id: '1234567890'
  member.messages.create msg_type: :text,     content: { content: 'test text' }.to_json
  member.messages.create msg_type: :image,    content: { pic_url: 'http://3g.1trip.com/Places/cseh/Images/map-Tubnil.jpg' }.to_json
  member.messages.create msg_type: :location, content: { location_x: 23.134521, location_y: 113.358803, scale: 20, label: '位置信息' }.to_json
  member.messages.create msg_type: :link,     content: {title: '公众平台官网链接', description: '公众平台官网链接', url: 'http://mp.weixin.qq.com/wiki/index.php?title=%E6%B6%88%E6%81%AF%E6%8E%A5%E5%8F%A3%E6%8C%87%E5%8D%97#.E5.9B.9E.E5.A4.8D.E9.9F.B3.E4.B9.90.E6.B6.88.E6.81.AF'}.to_json
  member.messages.create msg_type: :location, content: { event: 'subscribe', event_key: '1' }.to_json
  
  # Test Areas Data
  sichuan = Area.find_or_create_by name: '四川'
  yunan = Area.find_or_create_by name: '云南'
  
  # Test Replies Data
  Reply.find_or_create_by number: 1, name: '武侯祠', title: '武侯祠', content: '这里是武侯祠', area: sichuan
  Reply.find_or_create_by number: 2, name: '杜甫草堂', title: '杜甫草堂', content: '这里是杜甫草堂', area: sichuan
  Reply.find_or_create_by number: 3, name: '青城山', title: '青城山', content: '这里是青城山', area: yunan
  Reply.find_or_create_by number: 4, name: '峨眉山', title: '峨眉山', content: '这里是峨眉山', area: yunan
end

if Rails.env.production?
end