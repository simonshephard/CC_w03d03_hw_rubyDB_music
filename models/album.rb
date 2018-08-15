require_relative('artist')

class Album

  attr_reader :name

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
  end

end
