# Helper functions for determining platform

class Platform
	def self.mac?
	  PLATFORM =~ /darwin/
	end
	
	def self.windows?
	  PLATFORM =~ /mswin/
	end
	
	def self.linux?
		PLATFORM =~ /linux/
	end
	
	def self.short_name
	  if(mac?)
	    "osx"
    elsif(windows?)
      "windows"
    elsif(linux?)
      "linux"
    else
      "unknown"
    end
  end
end

# Used to get around stupid windows STL issues when ruby.h is included first.
# NOTE: It would better to do this with SWIG, but I could not figure out how.
def insert_headers(file)
	contents = File.open(file).read	
	header = yield+"\n"
	File.open(file, "w").write(header+contents)
end
