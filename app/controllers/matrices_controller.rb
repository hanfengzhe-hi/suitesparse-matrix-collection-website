class MatricesController < ApplicationController

  ### Resources methods ########################################################

  def index
    @filterrific = initialize_filterrific(
      Matrix,
      params[:filterrific],
      select_options: {
        sorted_by: Matrix.options_for_sorted_by,
        positive_definite_options: ['Yes', 'No'],
      }
    ) or return
    
    @matrices = @filterrific.find.page(params[:page])

    @per_page = params[:per_page] || session[:per_page] || 20
    if @per_page == "All"
      @per_page = Matrix.count
    end
    @matrices = @matrices.paginate(:page => params[:page], :per_page => @per_page)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def show
    if session[:admin_id]
      @admin = Admin.find(session[:admin_id])
    end

    # Get matrix info from the params
    id, group, name = params.values_at(:id, :group, :name)

    # Show the details page for a matrix
    @matrix = Matrix.find_by(id: id) || Matrix.find_by(name: name, group: group)
    if !@matrix
      render :not_found
    end
  end

  def new
    # TODO: Add admin interface to add a matrix to the database
  end

  def create
    # TODO: Add admin interface to create/save the new matrix
  end

  def destroy
  end

  def update
    # TODO: Add admin interface to update a matrix in the database
  end

end
