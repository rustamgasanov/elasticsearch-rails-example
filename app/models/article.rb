class Article < ActiveRecord::Base
  include ArticleSearchable
  has_many :tags, through: :article_tags
end
