class Cart
  include ActiveAttr::Model

  attr_accessible :user, :pickup_at, :return_at

  attribute :user
  attribute :pickup_at
  attribute :return_at
  attribute :things


  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    @things = ""
  end

  def persisted?
    false
  end


  def add_things(thing_array)

    things_to_array_of_ids

    if thing_array.class != Array
      thing_array = [thing_array]
    end

    new_things = thing_array.map {|t| t.id}

    @current_things << new_things
    @current_things.uniq!

    array_of_ids_to_things
    things_to_objects
  end

  def remove_things(thing_array)

    things_to_array_of_ids

    if thing_array.class != Array
      thing_array = [thing_array]
    end

    new_things = thing_array.map {|t| t.id}

    @current_things = @current_things - new_things

    array_of_ids_to_things
    things_to_objects
  end

  def things
    unless @things == ""
      things_to_array_of_ids
      things_to_objects
    else
      return []
    end
  end

private

  def things_to_objects
    @current_things.map {|i| Thing.find(i)}
  end

  def things_to_array_of_ids
    @current_things = @things.split(",").map {|i| i.to_i }
  end

  def array_of_ids_to_things
    @things = @current_things.join(",")
  end

end
