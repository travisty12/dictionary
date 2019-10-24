#!/usr/bin/ruby

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
	@words = Word.all
	erb(:words)
end

get('/words/new') do
	erb(:new_word)
end

get('/words/:id') do
	@word = Word.find(params[:id].to_i)
	erb(:word)
end

get('/words/:id/edit') do
	@word = Word.find(params[:id].to_i)
	erb(:edit_word)
end

get('/words/:word_id/definitions/:id') do
	@definition = Definition.find(params[:id].to_i)
	erb(:def)
end

get('/words/word_id/definitions/:id/edit') do
	@definition = Definition.find(params[:id].to_i)
	erb(:edit_def)
end
