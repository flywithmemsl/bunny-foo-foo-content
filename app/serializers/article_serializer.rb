class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :short, :slug, :cover_image, :category_id, :show_popup, :popup_delay, :popup_iframe_urls

  # belongs_to :category, serializer: CategorySerializer
end
