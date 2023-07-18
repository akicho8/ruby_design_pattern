class Logger
  def info(str)
    str
  end
end

class NullObject
  def info(str)
  end
end

logger = Logger.new
logger.info("x")                # => "x"

logger = NullObject.new
logger.info("x")                # => nil
