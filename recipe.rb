class Recipe
  attr_accessor :name, :description, :time, :difficult

  def initialize(name, description, time, difficult)
    if name.include?("[X]")
      name = name
    elsif name.include?("[ ]")
      name = name
    else
      name = "[ ] #{name}"
    end

    @name = name
    @description = description
    @time = time
    @difficult = difficult
  end
end
