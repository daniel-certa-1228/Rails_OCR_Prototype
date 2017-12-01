class DocMailer < ApplicationMailer

    def doc_mail(address)
        @address = address
        mail(to: @address, subject: 'This is a test.')
    end

end
