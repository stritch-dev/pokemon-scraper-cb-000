require 'pry-byebug'

class Pokemon
  attr_accessor :id, :name, :type, :db, :hp


  def initialize(id:, name:, type:, db:, hp: nil )
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
   db.execute("INSERT INTO pokemon (name, type) VALUES(:name, :type)", "name" => name, "type" => type)
  end

  def self.find(id, db)
    db.results_as_hash = true 
    results = db.execute("SELECT * FROM pokemon WHERE id = :id", "id" => id)
    results = results.first
    name = results['name']
    type = results['type']
    hp = results['hp']
    
    Pokemon.new(id: id, name: name, type: type,  db: db, hp: hp)
  end
  
  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = :hp WHERE id = :id", "hp" => hp, "id" => @id)
  end
end
