module Openfire
  class UserRoster
    attr_accessor :jid, :nickname, :subscription_type, :groups

    def initialize(attributes={})
      attributes.each do |k,v|
        self.send("#{to_underscore(k)}=", v)
      end
    end

    private

    def to_underscore(val)
      val.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
  end
end
