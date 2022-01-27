class GenerateApplicationTokenHelper
    def initialize
        string = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        token = (0...50).map { string[rand(string.length)] }.join
        token
    end
end

