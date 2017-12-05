class DocMailer < ApplicationMailer

    def doc_mail(address, description, content, attachment)
                                                    #the file needs an extra ../ on Heroku 
        attachments["#{attachment}.pdf"] = File.read( "../#{Rails.root}/#{attachment}.pdf")
        @address = address
        @description = description
        @content = content
        mail(to: @address, subject: 'This is a test.')
    end

end
