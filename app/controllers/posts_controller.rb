class PostsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  #Display User Info
  def index
      @posts = Post.all(:include => :user)
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @posts }
      end
    end
  
  #Save user_id after saving post
  def create
      authorize! :create, @post
      @post = Post.new(params[:post])
      @post.user_id = current_user.id
      
      respond_to do |format|
        if @post.save
          format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
          format.xml  { render :xml => @post, :status => :created, :location => @post }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
        end
      end
    end

  
  
end