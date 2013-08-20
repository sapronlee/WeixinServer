object @audio
if !@audio.errors.any?
  node(:id) { |o| o.id.to_s }
  attributes :title, :description, :file_size
  node(:file) { |o| o.file.url }
end