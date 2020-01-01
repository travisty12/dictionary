#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/reloader'
require './lib/word'
require './lib/definition'
require 'pry'
also_reload('lib/**/*.rb')

get('/') do
	erb(:home)
end

get('/words') do
	@words = []
	if (params[:search])
		@words = Word.search(params[:search])
	else
		@words = Word.all
	end
	
	erb(:words)
end

get('/words/new') do
	erb(:new_word)
end

post('/words') do
	name = params[:word_name]
	word = Word.new({:name => name, :id => nil})
	word.save
	@words = Word.all
	erb(:words)
end

get('/words/:id') do
	@word = Word.find(params[:id].to_i)
	erb(:word)
end

get('/words/:id/edit') do
	@word = Word.find(params[:id].to_i)
	erb(:edit_word)
end

patch('/words/:id') do 
	word = Word.find(params[:id].to_i)
	word.update(params[:name])
	@words = Word.all
	erb(:words)
end

post('/words/:word_id/definitions') do
	name = params[:definition_name]
	definition = Definition.new({:name => name, :word_id => params[:word_id].to_i, :id => nil})
	definition.save
	@word = Word.find(params[:word_id].to_i)
	erb(:word)
end

get('/words/:word_id/definitions/:id') do
	@definition = Definition.find(params[:id].to_i)
	erb(:definition)
end

patch('/words/:word_id/definitions/:id') do 
	@word = Word.find(params[:word_id].to_i)
	definition = Definition.find(params[:id].to_i)
	definition.update(params[:name], @word.id)
	erb(:word)
end

get('/words/word_id/definitions/:id/edit') do
	@definition = Definition.find(params[:id].to_i)
	erb(:edit_definition)
end

get('/definitions') do
	@definitions = []
	if (params[:search])
		@definitions = Definition.search(params[:search])
	else
		@definitions = Definition.all
	end
	
	erb(:definitions)
end

delete('/words/:id') do 
	word = Word.find(params[:id].to_i)
	if word.definitions.any?
		word.definitions.each do |definition|
			definition.delete
		end
	end
	word.delete
	@words = Word.all
	erb(:words)
end

delete('/words/:word_id/definitions/:id') do
	definition = Definition.find(params[:id].to_i)
	definition.delete
	@word = Word.find(params[:word_id].to_i)
	erb(:word)
end

