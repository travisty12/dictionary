class Definition
  attr_reader :id
  attr_accessor :name, :word_id

  @@definitions = {}
  @@total_rows = 0

  def initialize(name, word_id, id)
    @name = name
    @word_id = word_id
    @id = id || @@total_rows += 1
  end

  def ==(other_def)
    (self.name == other_def.name) && (self.word_id == other_def.word_id)
  end

  def self.all
    @@definitions.values
  end

  def self.clear
    @@definitions = {}
  end

  def save
    @@definitions[self.id] = Definition.new(self.name, self.word_id, self.id)
  end

  def self.find(id)
    @@definitions[id]
  end

  def self.find_by_word(word_id)
    definitions = []
    Definition.all.each do |defs|
      if defs.word_id == word_id
        definitions.push(defs)
      end
    end
    definitions
  end

  def word
    Word.find(self.word_id)
  end

  def update(name, word_id)
    self.name = name
    self.word_id = word_id
    @@definitions[self.id] = Definition.new(self.name, self.word_id, self.id)
  end

  def delete
    @@definitions.delete(self.id)
  end
end
