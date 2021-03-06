class Pokemon
    attr_accessor :name, :type, :id, :db
    def initialize(arg)
        @id = arg[:id]
        @name = arg[:name]
        @type = arg[:type]
        @db = arg[:db]
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?,?)
        SQL
     
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")
    # end
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL

       result = db.execute(sql,id).first
       new_pokemon = self.new(id: result[0], name: result[1], type:result[2])
        new_pokemon
    end
end 
