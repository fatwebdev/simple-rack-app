require_relative 'format_time'

class Application
  def call(env)
    @request = Rack::Request.new(env)
    puts @request.path_info
    if @request.path_info == '/time'
      format = @request.params['format'].split(',')

      status_code, response_body = FormatTime.new(format).call
      response(status_code, response_body)
    else
      response(404, 'Not Found')
    end
  end

  private

  def response(code, text)
    [
      code,
      { 'Content-Type' => 'text/plain' },
      [text]
    ]
  end
end
