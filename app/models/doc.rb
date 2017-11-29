class Doc < ApplicationRecord
    has_attached_file :avatar, styles: { small: "100x150", med: "300x450", large: "900x1200" }
    validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

    def self.fuzzy_content_search(search_string)
        search_string = "%" + search_string + "%"
        self.where("content LIKE ?", search_string)
    end

end
