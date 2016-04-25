module Openfire
  class User
    attr_accessor :username, :name, :email, :properties

    def initialize(attributes={})
      attributes.each do |k,v|
        self.send("#{k}=", v)
      end
    end
  end
end
