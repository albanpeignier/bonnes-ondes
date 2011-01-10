require 'acts_as_list'
class Page < ActiveRecord::Base
  belongs_to :show
  validates_presence_of :show_id

  acts_as_list :scope => :show
  liquid_methods :show, :title, :content
end
# TODO move this f... code anywhere else
class Page::LiquidDropClass

  def url_for
    view.url_for_page(@object)
  end

end
