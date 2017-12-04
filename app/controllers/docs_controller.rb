require 'ocr_space'
require 'rmagick'
require "mini_magick"
# require 'aws-sdk'
# require 'open-uri'
require 'stringio'

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

    def show
        @doc = Doc.find(params[:id])
    end

    def destroy
        @doc = Doc.find(params[:id])
        @doc.destroy
        redirect_to root_path
    end

    def search
        @search = params[:search_string]
        @docs = Doc.fuzzy_content_search(@search)
        render 'search'
    end

    def send_pdf
        @doc = Doc.find(params[:id])

        s3 = Aws::S3::Client.new(
            region: ENV.fetch('AWS_REGION'),
            access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
            secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY')
          )

        @jpeg = s3.get_object(bucket: ENV.fetch('S3_BUCKET_NAME'), key: "docs/#{@doc.id}.original.JPG")
        @new_pdf = Magick::Image.from_blob(@jpeg.body.read)[0]
        @new_pdf.write("#{@doc.description}.pdf")
        
    end

    def mail_it
        @email = params[:doc][:email]
        @description = params[:doc][:description]
        @content = params[:doc][:content]
        @attachment = params[:doc][:description]
        DocMailer.doc_mail(@email, @description, @content, @attachment).deliver_later
        redirect_to docs_path
        File.delete("#{@attachment}.pdf")
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
end
