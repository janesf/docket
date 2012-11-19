class String
  include Enumerable
 # Returns true if the string is its own reverse.
  def palindrome?
   self == self.reverse
   end
 end
   
