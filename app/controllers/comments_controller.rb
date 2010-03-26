class CommentsController < ProtectedController
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def related
    @comments = Comment.find_all_by_prayer_id(params[:id])
    
    respond_to do |format|
      format.rss { render :rss => @comments }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    if !current_user
      redirect_to root_url
    end
    
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Thanks for posting your comment'
        format.html { redirect_to(@comment) }
      else
        flash[:notice] = 'There was an error in saving your comment'
        format.html { render :action => "new" }
      end
    end
  end
end