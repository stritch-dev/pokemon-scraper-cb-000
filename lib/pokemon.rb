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
   db.execute("INSERT INTO pokemon (name, type) VALUES(?, ?)", name, type)
  end

  def self.find(id, db)
    results = db.execute("SELECT * FROM pokemon WHERE id=?", id)
    if results[0][3].nil?
      Pokemon.new(id: results[0][0], name: results[0][1], type: results[0][2], db: db)
    else
      Pokemon.new(id: results[0][0], name: results[0][1], type: results[0][2], hp: results[0][3], db: db)
    end
  end
  
  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp=? WHERE id=?", hp, @id)
  end
end
