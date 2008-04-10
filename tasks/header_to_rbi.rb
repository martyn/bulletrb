module CppParser
  class Parser
    attr_reader :klasses
    def initialize(file)
      hpp = File.open(file, "r").readlines
      @klasses = {"undefined" => []}
      @current_klass="undefined"
      @unable_to_parse = []
      hpp.each do |line|
        if(Klass.valid?(line))
          @current_klass = Klass.new(line).value
          @klasses[@current_klass] ||= []
        end
        if(line =~ /\(/)
          next if line =~ /\/\// || line =~ /__declspec/
          matched = false
          if(Constructor.valid?(line, @current_klass))
            # Constructor
            @klasses[@current_klass] << Constructor.new(line)
            matched = true
          end
          next if matched
          Method.scan(line) do |match|
            # Method
            matched = true
            @klasses[@current_klass] << Method.new(match)
          end
          next if matched
          
          @unable_to_parse << "#{@current_klass} '"+line.strip+"'"
        end
      end
        @klasses.delete "undefined" unless @klasses["undefined"].nil? || @klasses["undefined"].length > 0 
     end
    def to_rbi
      result = ""
      @klasses.each do |klass, methods|
        deriving, derived_from = klass.split("<").collect {|x| x.strip}
        unless(derived_from.nil? or @klasses[derived_from].nil?)
          @klasses[klass] -= @klasses[derived_from]
        end
      end
      @klasses.each do |klass, methods|

        result += "\nclass #{klass}\n"
        
        methods.sort_by{|x| x.name == "initialize" ? "0" : x.name}.each do |method|
          result += "  def #{method.name}"
          result += "(#{method.arguments})" if method.arguments
          result += "\n"
        end
      end
      if(@unable_to_parse.length > 0)
        result += "\n\n ERRORS:\n"+@unable_to_parse.join("\n")
      end
      result
    end
  end
  class Method
    attr_reader :name, :arguments
    def initialize(text)
      text.scan(/[\w\+\-\=\<\>\*\/\!]+\W*\(/) do |match|
        @name = match.sub("(", "").strip
      end
      unless(text =~ /\(\)/)
        text.scan(/\(.*\)/) do |match|
          @arguments = match.sub(/[\(\)]/, "").gsub("const", "").split(",")
          results = []
          @arguments.each do |argument|
            result, otherstuff = argument.split(" ")
            results << result.strip
          end
          @arguments = results.join(", ")
        end
      end
    end
    
    def self.scan(line)
      return if line =~ /define /
      line.scan(/[\w&]+\W+[\w\+\-\=\<\>\*\/\!]+\W*\(.*$/) do |match|
        yield match
      end
    end
  end
  
  class Constructor < Method
    def initialize(text)
      super(text)
      @name="initialize"
    end
    
    def self.valid?(line, current_klass)
      current_klass = current_klass.split.first
      line =~ /#{current_klass}\W*\(/
    end
  end
  
  class Klass
    attr_reader :name
    def initialize(text)
      @name = "undefined"
      text.scan(/(class|struct)\W+(\w+)/) do |match| 
        @name = match[1].strip.sub(/^bt/, "")
      end
      @extends=""
      text.scan(/:\W+public\W+(\w+)/) do |match|
        @extends = " < " + match[0].strip.sub(/^bt/, "")
      end
    end
    
    def <=>(other)
      name <=> other
    end
    
    def value
      name + @extends
    end
    
    def self.valid?(line)
      return false unless line =~ /(class|struct)\W+/
      return false if line =~ /(class|struct) \w+;$/
      return true
    end
  end
end
