require_relative 'format_time'

class Application
  def call(env)
    @request = Rack::Request.new(env)
    headers = { 'Content-Type' => 'text/plain' }

    if @request.path_info == '/time'
      format = @request.params['format'].split(',')

      status_code, response_body = FormatTime.new(format).call
      Rack::Response.new(response_body, status_code, headers)
    else
      Rack::Response.new('Not Found', 404, headers)
    end
  end
end
