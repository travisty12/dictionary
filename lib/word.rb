class Word
  attr_reader :id, :name

  @@words = {}
  @@total_rows = 0

  def initialize(name, id)
    @name = name
    @id = id || @@total_rows += 1
  end

  def self.all
    @@words.values
  end

  def save
    @@words[self.id] = Word.new(self.name, self.id)
  end

  def ==(other_word)
    self.name == other_word.name
  end

  def self.clear
    @@words = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@words[id]
  end

  def update(name)
    @name = name
  end

  def delete
    @@words.delete(self.id)
  end

  def self.search(name)
    output = []
    names = Word.all.map { |a| a.name }.grep(/#{name}/)
    names.each do |word_name|
      output.concat(Word.all.select { |word| word.name == word_name })
    end
    output
  end

  def definitions
    Definition.find_by_word(self.id)
  end
end
