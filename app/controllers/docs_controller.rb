require 'ocr_space'
# require 'rmagick'
require "mini_magick"

class DocsController < ApplicationController

    def index
        @docs = Doc.all
    end

    def create
        @doc = Doc.new(doc_params)
        to_text
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

    def to_text
        image = MiniMagick::Image.new(params[:doc][:avatar].path)
        image = image.resize "1200x1800"
        
        resource = OcrSpace::Resource.new(apikey: "0cf421d36788957")
        @doc.content = resource.clean_convert file: image.path
    end

    # def convert(jpg)
    #     image = MiniMagick::Image.new(jpg)
    #     image.resize "480x640"
    #     image.format "png"
    # end
end
