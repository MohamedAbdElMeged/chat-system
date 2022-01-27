module ApplicationService
    class CreateApplication
        def initialize(name)
            @name = name
            @token = GenerateApplicationTokenHelper.new
        end
        def call
            
        end
        def create_application
            @Application.create!({
                name: @name,
                token: @token
            })
        end
        
        
        
    end
end