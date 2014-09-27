module ArticleSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    # Customize the index name
    index_name 'elasticsearch-rails-example'

    # Customize the JSON serialization for Elasticsearch
    def as_indexed_json(options = {})
      attributes.merge({ 'tags' => tags.map(&:name).join(',') })
    end

    def self.search(query, options={})
      # Prefill and set the filters (top-level `filter` and `facet_filter` elements)
      __set_filters = lambda do |key, f|

        @search_definition[:filter][:and] ||= []
        @search_definition[:filter][:and]  |= [f]

        @search_definition[:facets][key.to_sym][:facet_filter][:and] ||= []
        @search_definition[:facets][key.to_sym][:facet_filter][:and]  |= [f]
      end

      filters = []

      @search_definition = {
        query: {},
        filter: {},
        sort: {},
        facets: {}
      }

      unless query.blank?
        @search_definition[:query] = {
          bool: {
            should: {
              multi_match: {
                query: query,
                fields: ['title^10', 'content'],
                operator: 'and'
              }
            }
          }
        }
        sort = {}
      else
        @search_definition[:query] = { match_all: {} }
        sort = { created_at: 'desc' }
      end

      if filters.present?
        @search_definition[:filter] = {
          and: filters
        }
      end

      @search_definition[:sort] = sort

      puts JSON.pretty_generate(@search_definition)

      __elasticsearch__.search(@search_definition)
    end
  end
end
