module ApplicationService
    class CreateApplication
        def initialize(name)
            @name = name
            @token = GenerateApplicationTokenHelper.create_token
        end
        def call
            create_application
            @application
        end
        private
        def create_application
            @application = Application.new({
                name: @name,
                token: @token
            })
            @application.save! if @application.valid?
            @application
        end
        
    end
end