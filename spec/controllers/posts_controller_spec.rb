require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PostsController do

  before(:each) do
    @show = Factory(:show)
    controller.stub!(:current_user).and_return(@show.users.first)

    @posts = mock("Array of Posts")    
  end

  def mock_post(stubs={})
    stubs = { :show => @show }.update(stubs)
    @mock_post ||= mock_model(Post, stubs)
  end

  describe "responding to GET index" do

    before(:each) do
      controller.stub!(:find_show).and_return(@show)
    end

    it "should expose all posts as @posts" do
      @show.should_receive(:posts).and_return(@posts)
      get :index, :show_id => @show
      assigns[:posts].should == @posts
    end

    describe "with mime type of xml" do
  
      it "should render all posts as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @show.should_receive(:posts).and_return(@posts)

        @posts.should_receive(:to_xml).and_return("generated XML")

        get :index, :show_id => @show
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    before(:each) do
      controller.stub!(:find_show).and_return(@show)
      @show.stub!(:posts).and_return(@posts)
    end

    it "should expose the requested post as @post" do
      @posts.should_receive(:find).with("37").and_return(mock_post)
      get :show, :id => "37"
      assigns[:post].should equal(mock_post)
    end
    
    describe "with mime type of xml" do

      it "should render the requested post as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        @posts.should_receive(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do

    before(:each) do
      controller.stub!(:find_show).and_return(@show)
      @show.stub!(:posts).and_return(@posts)
    end
  
    it "should expose a new post as @post" do
      @posts.should_receive(:build).and_return(mock_post)
      get :new
      assigns[:post].should equal(mock_post)
    end

  end

  describe "responding to GET edit" do

    before(:each) do
      controller.stub!(:find_show).and_return(@show)
      @show.stub!(:posts).and_return(@posts)
    end
  
    it "should expose the requested post as @post" do
      @posts.should_receive(:find).with("37").and_return(mock_post)
      get :edit, :id => "37"
      assigns[:post].should equal(mock_post)
    end

  end

  describe "responding to POST create" do

    before(:each) do
      controller.stub!(:find_show).and_return(@show)
      @show.stub!(:posts).and_return(@posts)
    end

    describe "with valid params" do
      
      it "should expose a newly created post as @post" do
        @posts.should_receive(:build).with({'these' => 'params'}).and_return(mock_post(:save => true))
        post :create, :post => {:these => 'params'}
        assigns(:post).should equal(mock_post)
      end

      it "should redirect to the created post" do
        @posts.stub!(:build).and_return(mock_post(:save => true))
        post :create, :post => {}
        response.should redirect_to(admin_show_post_url(@show, mock_post))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved post as @post" do
        @posts.stub!(:build).with({'these' => 'params'}).and_return(mock_post(:save => false))
        post :create, :post => {:these => 'params'}
        assigns(:post).should equal(mock_post)
      end

      it "should re-render the 'new' template" do
        @posts.stub!(:build).and_return(mock_post(:save => false))
        post :create, :post => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    before(:each) do
      controller.stub!(:find_show).and_return(@show)
      @show.stub!(:posts).and_return(@posts)
    end

    describe "with valid params" do

      it "should update the requested post" do
        @posts.should_receive(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :post => {:these => 'params'}
      end

      it "should expose the requested post as @post" do
        @posts.stub!(:find).and_return(mock_post(:update_attributes => true))
        put :update, :id => "1"
        assigns(:post).should equal(mock_post)
      end

      it "should redirect to the post" do
        @posts.stub!(:find).and_return(mock_post(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(admin_show_post_url(@show, mock_post))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested post" do
        @posts.stub!(:find).with("37").and_return(mock_post)
        mock_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :post => {:these => 'params'}
      end

      it "should expose the post as @post" do
        @posts.stub!(:find).and_return(mock_post(:update_attributes => false))
        put :update, :id => "1"
        assigns(:post).should equal(mock_post)
      end

      it "should re-render the 'edit' template" do
        @posts.stub!(:find).and_return(mock_post(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    before(:each) do
      controller.stub!(:find_show).and_return(@show)
      @show.stub!(:posts).and_return(@posts)
    end

    it "should destroy the requested post" do
      @posts.should_receive(:find).with("37").and_return(mock_post)
      mock_post.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the posts list" do
      @posts.stub!(:find).and_return(mock_post(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(admin_show_posts_url(@show))
    end

  end

end
