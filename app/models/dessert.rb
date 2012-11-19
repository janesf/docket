class Dessert
  attr_accessor :name, :calories
    def initialize(name, calories)
        # Your c
        @name = name
        @calories = calories
    end

    def healthy?
        # Your code here
        true unless @calories >= 200
        
    end

    def delicious?
        # Your code here
        true
    end
end

class JellyBean < Dessert
  attr_accessor :flavor
    def initialize(name, calories, flavor)
        # Your code here
        @flavor = flavor
    end

    def delicious?
        # Your code here
      true unless @flavor == 'black licorice'
    end
end

