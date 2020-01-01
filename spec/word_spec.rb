require('rspec')
require('word')
require 'definition'

describe('#Word') do
  before(:each) do
    Word.clear
  end

  describe('.all') do
    it("returns an empty array when there are no words") do
      expect(Word.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a word") do
      word = Word.new({ :name => "Fumple", :id => nil })
      word.save
      word2 = Word.new({ :name => "Clispicon", :id => nil })
      word2.save
      expect(Word.all).to(eq([word,word2]))
    end
  end

  describe('#==') do
    it("is the same word if it has the same attributes as another word") do
      word = Word.new({ :name => "Fumple", :id => nil })
      word2 = Word.new({ :name => "Fumple", :id => nil })
      expect(word).to(eq(word2))
    end
  end

  describe('.clear') do
    it("clears the dictionary") do
      word = Word.new({ :name => "Fumple", :id => nil })
      word.save
      word2 = Word.new({ :name => "Clispicon", :id => nil })
      word2.save
      Word.clear
      expect(Word.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a word by id") do
      word = Word.new({ :name => "Fumple", :id => nil })
      word.save
      word2 = Word.new({ :name => "Clispicon", :id => nil })
      word2.save
      expect(Word.find(word.id)).to(eq(word))
    end
  end

  describe('#update') do
    it("updates a word's name") do
      word = Word.new({ :name => "Fumple", :id => nil })
      word.save
      word.update("Clispicon")
      expect(word.name).to(eq("Clispicon"))
    end
  end

  describe('#delete') do
    it("deletes a word by id") do
      word = Word.new({ :name => "Fumple", :id => nil })
      word.save
      word2 = Word.new({ :name => "Clispicon", :id => nil })
      word2.save
      word.delete
      expect(Word.all).to(eq([word2]))
    end
  end

  describe('.search') do
    it("finds a word by name") do
      word = Word.new({ :name => "Fumple", :id => nil })
      word.save
      word2 = Word.new({ :name => "Clispicon", :id => nil })
      word2.save
      word3 = Word.new({ :name => "Zongdat", :id => nil })
      word3.save
      expect(Word.search("on")).to(eq([word2, word3]))
    end
  end

  describe('#definitions') do
    it("returns a word definitions") do
      word = Word.new({ :name => "Frumple", :id => nil })
      word.save
      definition = Definition.new({ :name => "To trip and do a somersault", :word_id => word.id, :id => nil })
      definition.save
      definition2 = Definition.new({ :name => "The lint in your bellybutton", :word_id => word.id, :id => nil })
      definition2.save
      expect(word.definitions).to(eq([definition, definition2]))
    end
  end
end
