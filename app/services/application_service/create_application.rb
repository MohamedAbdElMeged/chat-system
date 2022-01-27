module ApplicationService
    class CreateApplication
        def initialize(name)
            @name = name
            @token = GenerateApplicationTokenHelper.new.create_token
        end
        def call
            create_application
            @application
        end
        private
        def create_application
            @application = Application.create!({
                name: @name,
                token: @token
            })
        end
        
    end
end