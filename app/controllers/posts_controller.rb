require "open-uri"

# ALL OF THIS CAN PROBABLY GO :)


class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  private

  def call_successful?(response)
    errors = ["error", "fail"]
    return false if errors.include?(response['status'])

    true
  end
end
