class FormatTime
  FORMATS = {
    'year' => '%Y-',
    'month' => '%m-',
    'day' => '%d ',
    'hour' => '%H:',
    'minute' => '%M:',
    'second' => '%S'
  }.freeze

  def initialize(formats)
    @template_string = ''
    @unknown = []
    parser(formats)
  end

  def call
    if @unknown.empty?
      time
    else
      unknown_format
    end
  end

  private

  def unknown_format
    [
      400,
      "Unknown time format #{@unknown}"
    ]
  end

  def time
    [
      200,
      Time.now.strftime(@template_string)
    ]
  end

  def parser(formats)
    formats.each do |format|
      if FORMATS[format]
        @template_string += FORMATS[format]
      else
        @unknown << format
      end
    end
  end
end
