class SensitivesController < ApplicationController
  load_and_authorize_resource
  def index
    @menu = 'admins'
    @words = Sensitive.words
  end

  def batch_save
    @menu = 'admins'
    @words = params[:words]
    all_words = @words.squeeze(" ").split(/ |,|-/)
    Sensitive.delete_all(["word not in (?)", all_words])
    all_words.each do |item|
      if Sensitive.find_by_word(item).nil?
        Sensitive.create(:word => item)
      end
    end
    redirect_to sensitives_path
  end

end
