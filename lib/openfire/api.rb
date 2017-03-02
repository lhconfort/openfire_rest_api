module Openfire
  class Api
    def initialize(endpoint_url, access_token)
      @endpoint_url = endpoint_url
      @access_token = access_token
    end

    def get_users(filters={})
      request = web_request('GET', '/users', filters, default_headers)
      request[:body]['user'].map { |x| Openfire::User.new(x) }
    end

    def get_user(username)
      request = web_request('GET', "/users/#{username}", { }, default_headers)
      Openfire::User.new(request[:body])
    end

    def create_user(user_data={})
      request = web_request('POST', '/users', user_data.to_json, default_headers)
      (request[:status_code] == 201)
    end

    def update_user(username, user_data={})
      request = web_request('PUT', "/users/#{username}", user_data.to_json, default_headers)
      (request[:status_code] == 200)
    end

    def delete_user(username)
      request = web_request('DELETE', "/users/#{username}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def lock_user(username)
      request = web_request('POST', "/lockouts/#{username}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def unlock_user(username)
      request = web_request('DELETE', "/lockouts/#{username}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def get_user_groups(username)
      request = web_request('GET', "/users/#{username}/groups", { }, default_headers)
      body = request[:body]['groupname']
      body.is_a?(Array) ? body : [body]
    end

    def add_user_to_group(username, groupname)
      request = web_request('POST', "/users/#{username}/groups/#{groupname}", { }, default_headers)
      (request[:status_code] == 201)
    end

    def add_user_to_groups(username, groupnames)
      payload = { groupname: groupnames }.to_json
      request = web_request('POST', "/users/#{username}/groups", payload, default_headers)
      (request[:status_code] == 201)
    end

    def delete_user_from_group(username, groupname)
      request = web_request('DELETE', "/users/#{username}/groups/#{groupname}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def delete_user_from_groups(username, groupnames)
      payload = { groupname: groupnames }.to_json
      request = web_request('DELETE', "/users/#{username}/groups", payload, default_headers)
      (request[:status_code] == 200)
    end

    def get_user_roster(username)
      request = web_request('GET', "/users/#{username}/roster", { }, default_headers)
      Openfire::UserRoster.new(request[:body])
    end

    def create_user_roster(username, roster_data={})
      request = web_request('POST', "/users/#{username}/roster", roster_data.to_json, default_headers)
      (request[:status_code] == 201)
    end

    def delete_user_roster(username, jid)
      request = web_request('DELETE', "/users/#{username}/roster/#{jid}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def update_user_roster(username, jid, roster_data={})
      request = web_request('PUT', "/users/#{username}/roster/#{jid}", roster_data.to_json, default_headers)
      (request[:status_code] == 200)
    end

    def get_chatrooms(filters={})
      request = web_request('GET', '/chatrooms', filters, default_headers)
      request[:body]['chatroom'].map { |x| Openfire::ChatRoom.new(x) }
    end

    def get_chatroom(room_name)
      request = web_request('GET', "/chatrooms/#{room_name}", { }, default_headers)
      Openfire::ChatRoom.new(request[:body])
    end

    def get_chatroom_participants(room_name)
      request = web_request('GET', "/chatrooms/#{room_name}/participants", { }, default_headers)
      request[:body]
    end

    def get_chatroom_occupants(room_name)
      request = web_request('GET', "/chatrooms/#{room_name}/occupants", { }, default_headers)
      request[:body]
    end

    def create_chatroom(room_data={})
      request = web_request('POST', '/chatrooms', room_data.to_json, default_headers)
      (request[:status_code] == 201)
    end

    def delete_chatroom(room_name)
      request = web_request('DELETE', "/chatrooms/#{room_name}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def update_chatroom(room_name, room_data={})
      request = web_request('PUT', "/chatrooms/#{room_name}", room_data.to_json, default_headers)
      (request[:status_code] == 200)
    end

    def add_user_to_chatroom(room_name, role, username_or_jid, params={})
      request = web_request('POST', "/chatrooms/#{room_name}/#{role}/#{username_or_jid}", params, default_headers)
      (request[:status_code] == 201)
    end

    def delete_user_from_chatroom(room_name, role, username_or_jid, params={})
      request = web_request('DELETE', "/chatrooms/#{room_name}/#{role}/#{username_or_jid}", params, default_headers)
      (request[:status_code] == 200)
    end

    def get_system_properties
      request = web_request('GET', '/system/properties', { }, default_headers)
      request[:body]['property'].map { |x| Openfire::SystemProperty.new(x) }
    end

    def get_system_property(property_name)
      request = web_request('GET', "/system/properties/#{property_name}", { }, default_headers)
      Openfire::SystemProperty.new(request[:body])
    end

    def create_system_property(property_name, value)
      payload = {
        '@key' => property_name,
        '@value' => value
      }.to_json
      request = web_request('POST', '/system/properties', payload, default_headers)
      (request[:status_code] == 201)
    end

    def delete_system_property(property_name)
      request = web_request('DELETE', "/system/properties/#{property_name}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def update_system_property(property_name, value)
      payload = {
        '@key' => property_name,
        '@value' => value
      }.to_json
      request = web_request('PUT', "/system/properties/#{property_name}", payload, default_headers)
      (request[:status_code] == 200)
    end

    def get_concurrent_sessions_count
      request = web_request('GET', '/system/statistics/sessions', { }, default_headers)
      Openfire::SessionsCount.new(request[:body])
    end

    def get_groups
      request = web_request('GET', '/groups', { }, default_headers)
      request[:body]['group'].map { |x| Openfire::Group.new(x) }
    end

    def get_group(groupname)
      request = web_request('GET', "/groups/#{groupname}", { }, default_headers)
      Openfire::Group.new(request[:body])
    end

    def create_group(group_data)
      request = web_request('POST', '/groups', group_data.to_json, default_headers)
      (request[:status_code] == 201)
    end

    def update_group(groupname, group_data={})
      request = web_request('PUT', "/groups/#{groupname}", group_data.to_json, default_headers)
      (request[:status_code] == 200)
    end

    def delete_group(groupname)
      request = web_request('DELETE', "/groups/#{groupname}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def get_sessions
      request = web_request('GET', '/sessions', { }, default_headers)
      data = request[:body]['session']
      if data.is_a?(Array)
        data.map { |x| Openfire::Session.new(x) }
      else
        [Openfire::Session.new(data)]
      end
    end

    def get_user_sessions(username)
      request = web_request('GET', "/sessions/#{username}", { }, default_headers)
      data = request[:body]['session']
      if data.is_a?(Array)
        data.map { |x| Openfire::Session.new(x) }
      else
        [Openfire::Session.new(data)]
      end
    end

    def close_user_sessions(username)
      request = web_request('DELETE', "/sessions/#{username}", { }, default_headers)
      (request[:status_code] == 200)
    end

    def send_broadcast_message(message_text)
      payload = { body: message_text }.to_json
      request = web_request('POST', '/messages/users', payload, default_headers)
      (request[:status_code] == 201)
    end

    private

    def default_headers
      {
        content_type: :json,
        accept: :json,
        authorization: @access_token
      }
    end

    def web_request(uri_method, action, params={}, headers={})
      begin
        parse_response(RestClient::Request.execute({
          method: uri_method,
          url: "#{@endpoint_url}#{action}",
          payload: params,
          headers: headers
        }))
      rescue => e
        parse_response(e.response)
      end
    end

    def parse_response(response)
      result = {
        headers: response.headers,
        body: (JSON.parse(response.body) rescue response.body),
        status_code: response.code
      }

      result
    end
  end
end

