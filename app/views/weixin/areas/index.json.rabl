child(:@areas => :results) { attributes :id, :name, :created_at }
glue(:@areas) do |a|
  node(:meta) do
  {
    total: @areas.total_count
  }
  end
end