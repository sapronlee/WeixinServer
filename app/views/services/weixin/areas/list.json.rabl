object false
child @areas.to_a, object_root: false do |area|
  node(:id) { |o| o.id.to_s }
  attributes :name
end