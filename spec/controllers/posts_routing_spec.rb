require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do
  describe "route generation" do

    it "should map { :controller => 'posts', :action => 'index', :show_id => 1 } to /compte/shows/1/posts" do
      route_for(:controller => "posts", :action => "index", :show_id => "1").should == "/compte/shows/1/posts"
    end
  
    it "should map { :controller => 'posts', :action => 'new', :show_id => 1 } to /compte/shows/1/posts/new" do
      route_for(:controller => "posts", :action => "new", :show_id => "1").should == "/compte/shows/1/posts/new"
    end
  
    it "should map { :controller => 'posts', :action => 'show', :id => 1, :show_id => 1 } to /compte/shows/1/posts/1" do
      route_for(:controller => "posts", :action => "show", :id => "1", :show_id => "1").should == "/compte/shows/1/posts/1"
    end
  
    it "should map { :controller => 'posts', :action => 'edit', :id => 1, :show_id => 1 } to /compte/shows/1/posts/1/edit" do
      route_for(:controller => "posts", :action => "edit", :id => "1", :show_id => "1").should == "/compte/shows/1/posts/1/edit"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'posts', action => 'index' } from GET /posts" do
      params_from(:get, "/compte/shows/1/posts").should == {:controller => "posts", :action => "index", :show_id => "1"}
    end
  
    it "should generate params { :controller => 'posts', action => 'new', :show_id => 1} from GET /posts/new" do
      params_from(:get, "/compte/shows/1/posts/new").should == {:controller => "posts", :action => "new", :show_id => "1"}
    end
  
    it "should generate params { :controller => 'posts', action => 'create', :show_id => 1} from POST /posts" do
      params_from(:post, "/compte/shows/1/posts").should == {:controller => "posts", :action => "create", :show_id => "1"}
    end
  
    it "should generate params { :controller => 'posts', action => 'show', id => '1', :show_id => 1} from GET /posts/1" do
      params_from(:get, "/compte/shows/1/posts/1").should == {:controller => "posts", :action => "show", :id => "1", :show_id => "1"}
    end
  
    it "should generate params { :controller => 'posts', action => 'edit', id => '1', :show_id => 1} from GET /posts/1;edit" do
      params_from(:get, "/compte/shows/1/posts/1/edit").should == {:controller => "posts", :action => "edit", :id => "1", :show_id => "1"}
    end
  
    it "should generate params { :controller => 'posts', action => 'update', id => '1', :show_id => 1} from PUT /posts/1" do
      params_from(:put, "/compte/shows/1/posts/1").should == {:controller => "posts", :action => "update", :id => "1", :show_id => "1"}
    end
  
    it "should generate params { :controller => 'posts', action => 'destroy', id => '1', :show_id => 1} from DELETE /posts/1" do
      params_from(:delete, "/compte/shows/1/posts/1").should == {:controller => "posts", :action => "destroy", :id => "1", :show_id => "1"}
    end
  end
end
