object @article_group
node(:id) { |o| o.id.to_s }
attributes :name
child @article_group.articles.to_a do
  node(:id) { |o| o.id.to_s }
  attributes :title, :description, :content, :url, :master
  child :article_cover do
    node(:id) { |o| o.id.to_s }
    node(:big_file) { |o| o.file.weixin_big_cover.url }
    node(:small_file) { |o| o.file.weixin_small_cover.url }
  end
end