class Numeric
   attr_accessor :currencie
 @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}

 
 def method_missing(method_id)
   
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
#     self.currencie = singular_currency        
#     puts "method finished"
     self * @@currencies[singular_currency] # just change the order of expressions
    else
     super
    end
  end
 
 def self.add_currency(name,conversion)
   @@currencies[name.to_s] = conversion
 end
 def in(convert_to) 
  # self * @@currencies[convert_to.to_s]
   singular_currency = convert_to.to_s.gsub(/s$/, '')
   self / @@currencies[singular_currency]
   
 end

end

class String
  include Enumerable
 # Returns true if the string is its own reverse.
  def palindrome?
   self == self.reverse
   end
 end
 class Array
   include Enumerable
  # Returns true if the string is its own reverse.
   def palindrome?
     puts self.reverse
    self == self.reverse
    end
  end