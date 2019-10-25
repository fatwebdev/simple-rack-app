require_relative 'format_time'

class Application
  HEADERS = { 'Content-Type' => 'text/plain' }.freeze

  def call(env)
    @request = Rack::Request.new(env)

    if @request.path_info == '/time'
      process_time
    else
      Rack::Response.new('Not Found', 404, HEADERS)
    end
  end

  private

  def process_time
    format = @request.params['format'].split(',')
    time, errors = FormatTime.new(format).call

    if errors
      Rack::Response.new(errors, 400, HEADERS)
    else
      Rack::Response.new(time, 200, HEADERS)
    end
  end
end
