module Openfire
  class Session
    attr_accessor :session_id, :username, :resource, :node, :session_status,
      :presence_status, :presence_message, :priority, :host_address, :host_name,
      :creation_date, :last_action_date, :secure

    def initialize(attributes={})
      time_attrs = ['creationDate', 'lastActionDate']
      boolean_attrs = ['secure']

      attributes.each do |k,v|
        if k == 'ressource'
          self.resource = v
        elsif time_attrs.include?(k)
          self.send("#{to_underscore(k)}=", Time.parse(v)) unless v.nil?
        elsif boolean_attrs.include?(k)
          self.send("#{to_underscore(k)}=", v == 'true')
        else
          self.send("#{to_underscore(k)}=", v)
        end
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
