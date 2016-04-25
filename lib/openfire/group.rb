module Openfire
  class Group
    attr_accessor :name, :description

    def initialize(attributes={})
      attributes.each do |k,v|
        self.send("#{k}=", v)
      end
    end
  end
end
