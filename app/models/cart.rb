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
    if thing_array.class != Array
      thing_array = [thing_array]
    end
    thing_array.each do |thing|
      unless things_to_array_of_ids.include?(thing.id)
        @things += thing.id.to_s + ","
      end
    end

    things_to_objects
  end

  def things
    unless @things == ""
      things_to_objects
    else
      return []
    end
  end

private

  def things_to_objects
    things_to_array_of_ids.map {|i| Thing.find(i)}
  end

  def things_to_array_of_ids
    @things.split(",").map {|i| i.to_i }
  end

end
