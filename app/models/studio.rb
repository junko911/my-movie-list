class Studio
  attr_reader :name
  @@all = []

  def initialize(name)
    @name = name
    Studio.all << self
  end

  def self.all
    @@all
  end

  def movies
    Movie.all.select { |movie| movie.studio == self}
  end

  def self.find_studio_by_name_or_create_new(passed_name)
    found_studio = all.find { |studio| studio.name == passed_name}
    if found_studio
      found_studio
    else
      Studio.new(passed_name)
    end
  end
end