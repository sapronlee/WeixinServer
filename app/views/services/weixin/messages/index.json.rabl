object false
node(:messages_count){ |m| @messages.total_count }
child @messages, object_root: false do |message|
  node(:id){ |o| o.id.to_s }
  node(:name){ |c| c.member.account.name }
  node(:open_id){ |c| c.member.open_id }
  node(:msgtype){ |c| Message.human_enum_name :msg_type, c.msg_type }
  node(:content) do |c|
    hash = ActiveSupport::JSON.decode(c.content)
    case c.msg_type
    when :text
      hash['content']
    when :image
      hash['pic_url']
    when :location
      "#{hash['location_x']}, #{hash['location_y']}"
    when :link
      truncate(hash['url'], length: 70)
    when :event
      hash['event']
    end

  end
  attributes :created_at
end