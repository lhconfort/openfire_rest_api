module Openfire
  class Api
    def initialize(endpoint_url, access_token)
      @endpoint_url = endpoint_url
      @access_token = access_token
    end

    def get_users
      request = web_request('GET', '/users', { }, default_headers)
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

