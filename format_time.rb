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
    @formats = formats
  end

  def call
    parser
    if @unknown.empty?
      time
    else
      unknown_format
    end
  end

  private

  def unknown_format
    [
      nil,
      "Unknown time format #{@unknown}"
    ]
  end

  def time
    [
      Time.now.strftime(@template_string),
      nil
    ]
  end

  def parser
    @formats.each do |format|
      if FORMATS[format]
        @template_string += FORMATS[format]
      else
        @unknown << format
      end
    end
  end
end
