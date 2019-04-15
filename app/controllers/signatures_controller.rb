class SignaturesController < ApplicationController
  def new
    @signature = Signature.new
  end

  def create
    @signature = Signature.new(signature_params)
    @contract = Contract.find(params[:contract_id])
    if @signature.save
      respond_to do |format|
        format.html { redirect_to  }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'restaurants/show' }
        format.js  # <-- idem
      end
    end
  end

  private
  def signature_params
    params.require(:signature).permit(:signature)
  end
end
