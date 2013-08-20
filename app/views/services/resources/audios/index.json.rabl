object false
node(:audios_count) { |m| @audios.total_count }
child @audios.to_a, object_root: false do
  node(:id) { |o| o.id.to_s }
  attributes :title, :description
  node(:created_at) { |o| I18n.l(o.created_at, format: :long) }
  node(:updated_at) { |o| I18n.l(o.updated_at, format: :long) }
  node(:file) { |o| o.file.url }
end
