class EntriesController < ApplicationController

  def new
    if current_user && current_user.admin?
      @entry = Entry.new
    else
      redirect_to root_url, notice: 'Please login to add an entry'
    end
  end

  def create
    if current_user
      @entry = Entry.new(entry_params)
      if @entry.save
        redirect_to list_url, notice: 'Added entry'
      else
        render 'new'
      end
    else
      redirect_to root_url, notice: 'Please login to add an entry'
    end
  end

  def show
    if current_user
      @entry = Entry.find_by_id(params[:id])
      redirect_to root_url, notice: 'the selected entry does not exist' unless @entry
    else
      redirect_to root_url, notice: 'Please login to view entries'
    end
  end

  def entry_params
    params.require(:entry).permit(:name, :cnpj, :description)
  end

  def list
    if current_user
      if params[:q].present?
        search_items = params[:q].to_s.split(' ')
        @list = Entry.search search_items
        unless @list
          redirect_to list_url, notice: "Couldn't find the search terms #{params[:q]}"
        end
      else
        @list = Entry.all
      end
    else
      redirect_to root_url, notice: 'Please login to view the list'
    end
  end

  def destroy
    if current_user && current_user.admin
      entry = Entry.find_by_id(params[:id])
      entry.destroy!
      redirect_to root_url, notice: 'Entry successfully removed'
    else
      redirect_to root_url, notice: 'Only admins can remove users'
    end
  end

  private :entry_params

end
