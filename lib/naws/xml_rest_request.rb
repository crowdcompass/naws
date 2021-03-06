require 'naws/request'
require 'builder'

# This type of AWS request is used for REST APIs which include an XML body.
class Naws::XmlRestRequest < Naws::Request
  
  def to_xml
    x = Builder::XmlMarkup.new
    x.instruct!
    xml x
  end
 
  def body
    to_xml
  end

  protected

    def xml(x)
      raise NotImplementedError, "Need to implement #xml if you're inheriting from XmlRestRequest"
    end

    def add_headers(h)
      h["Content-Type"] = "text/xml"
      super
    end


end
