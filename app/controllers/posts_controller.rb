require "open-uri"

class PostsController < ApplicationController

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
