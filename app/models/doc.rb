class Doc < ApplicationRecord
    has_attached_file :avatar, styles: { small: "50x75", med: "100x150", large: "200x300" }
    validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    # before_save :convert
    
    # private
    # def convert
    #     resource = OcrSpace::Resource.new(apikey: "0cf421d36788957")
    #     content = resource.clean_convert file: 
    #     @doc.content = content
    # end
end
