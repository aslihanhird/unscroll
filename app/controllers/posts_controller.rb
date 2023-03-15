require "open-uri"

class PostsController < ApplicationController

  def update
    @post = Post.find(params[:id])
    case @post.favourite
    when true then @post.update(favourite: false)
    when false then @post.update(favourite: true)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    raise
  end

  private

  # NANI???
  def call_successful?(response)
    errors = ["error", "fail"]
    return false if errors.include?(response['status'])

    true
  end
end
