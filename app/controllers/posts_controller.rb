require "open-uri"

class PostsController < ApplicationController
  before_action :find_post

  def show
  end

  def read
    @post.read = true
    @post.save
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    puts "Successful Update #{@post.id} - #{@post.read}"
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end
