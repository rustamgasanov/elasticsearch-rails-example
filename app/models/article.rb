class Article < ActiveRecord::Base
  include ArticleSearchable

  has_many :article_tags
  has_many :tags, through: :article_tags

  accepts_nested_attributes_for :tags
end
