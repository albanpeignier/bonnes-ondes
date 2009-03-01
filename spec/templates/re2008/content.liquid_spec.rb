require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "re2008/content" do

  fixtures :contents

  before do
    @template = Template.new :slug => 're2008'

    @content = contents(:first)
    @episode = @content.episode

    @content_liquid = @content.to_liquid
    # to use always the same instance
    @content.stub!(:to_liquid).and_return(@content_liquid) 
  end

  def render_template(view, object)
    template.finder.view_paths = ["#{RAILS_ROOT}/templates"]
    assigns[:theme] = @template
    assigns[view.to_sym] = object # TODO see why render locals are ignored ?
    render :layout => false, :template => "#{@template.slug}/#{view}",
      :locals => { view.to_sym => object }
  end

  
  it "should have title 'Esperanzah! 2008 - Radio - Ecouter content_episode_title - content_name'" do
    @content.name = 'content_name'
    @episode.title = 'content_episode_title'
    
    render_template :content, @content
    response.should have_tag('title', 'Esperanzah! 2008 - Radio - Ecouter content_episode_title - content_name')
  end

  it "should display content embedded player" do
    @content_liquid.should_receive(:embedded_player).and_return("<embed id='test'/>")
    render_template :content, @content
    response.should have_tag('embed[id=test]')
  end

end
