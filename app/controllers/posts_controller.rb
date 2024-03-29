require "open-uri"

class PostsController < ApplicationController
  before_action :find_post

  def read
    @post.read = true
    @post.save
  end

  def update
    @post = Post.find(params[:id])
    case @post.favourite
    when true then @post.update(favourite: false)
    when false then @post.update(favourite: true)
    end

    redirect_to favourites_path if request.referrer.match(/.*\/favourites\/?$/)
  end

  def show
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end
