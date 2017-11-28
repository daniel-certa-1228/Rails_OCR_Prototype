require 'ocr_space'

class DocsController < ApplicationController

    def index
        @docs = Doc.all
    end

    def create
        @doc = Doc.new(doc_params)
        convert
        if @doc.save
            redirect_to docs_path
        else
            render 'new'
        end
    end

    def update
        @doc = Doc.find(params[:id])
        if @doc.update(customer_params)
            redirect_to @doc
        else
            render 'edit'
        end
    end

    def destroy
        @doc = Doc.find(params[:id])
        @doc.destroy
        redirect_to root_path
    end

    private
    def doc_params
        params.require(:doc).permit(:description, :date, :content, :avatar )
    end

    def convert
        resource = OcrSpace::Resource.new(apikey: "0cf421d36788957")
        content = resource.clean_convert file: params[:doc][:avatar].path
        @doc.content = content
    end
end
