class Article < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  # mapping do
  #   indexes :published_on, type: 'date', include_in_all: false
  # end
  def self.search(params)
    tire.search(load: true) do
      query do
        string params[:query], :default_operator => 'AND'
        # filter :range, published_at: {lte: Time.zone.now }
      end
      facet('published_on') {date :published_on}
      end
  end
end
