object false
node(:areas_count) { |m| @areas.total_count }
child @areas, object_root: false do |area|
  node(:id) { |o| o.id.to_s }
  attributes :name, :created_at
end