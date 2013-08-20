object @audio
if !@audio.errors.any?
  node(:id) { |o| o.id.to_s }
  node(:file) { |o| o.file.url }
  node(:duration) { |o| o.file_duration }
  attributes :title, :description
end