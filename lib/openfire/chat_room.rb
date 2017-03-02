module Openfire
  class ChatRoom
    attr_accessor :room_name, :natural_name, :description, :subject, :password,
      :creation_date, :modification_date, :max_users, :persistent, :publicRoom,
      :registrationEnabled, :can_anyone_discover_jid, :can_occupants_change_subject,
      :can_occupants_invite, :can_change_nickname, :log_enabled, :login_restricted_to_nickname,
      :members_only, :moderated, :broadcast_presence_roles, :owners, :admins, :members,
      :outcasts, :owner_groups, :admin_groups, :member_groups, :outcast_groups

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
