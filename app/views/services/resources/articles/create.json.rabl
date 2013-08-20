object @article
if !@article.errors.any?
  node(:id) { |o| o.id.to_s }
  attributes :title, :description, :content, :url, :master
  child :article_cover do
    node(:id) { |o| o.id.to_s }
    node(:big_file) { |o| o.file.weixin_big_cover.url }
    node(:small_file) { |o| o.file.weixin_small_cover.url }
  end
  child :article_group do
    node(:id) { |o| o.id.to_s }
  end
end