class CartesianProduct
  include Enumerable
  
 def initialize(a,b)
   @a = a
   @b = b
 end
 
 def each
   return to_enum unless block_given?
    @a.each do |u|
      @b.each {|v| yield [u,v]}
    end
  end

end