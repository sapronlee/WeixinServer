object @article_cover
if !@article_cover.errors.any?
  node(:id) { |o| o.id.to_s }
  node(:big_file) { |o| o.file.weixin_big_cover.url }
  node(:small_file) { |o| o.file.weixin_small_cover.url }
end