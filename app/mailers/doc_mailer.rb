class DocMailer < ApplicationMailer

    def doc_mail(address, description, content)
        @address = address
        @description = description
        @content = content
        mail(to: @address, subject: 'This is a test.')
    end

end
