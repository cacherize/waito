class TagSearchController < ApplicationController
  def index
    return unless params[:term]

    results = Tag.where(['lower(name) LIKE ?', "%#{params[:term].downcase}%"])

    render :json => results.to_json(:only => [ :id, :name ]), :callback => params['callback']
  end
end
