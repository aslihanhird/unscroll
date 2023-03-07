class InstaPostsController < ApplicationController
  def create
    @insta_post = InstaPost.new(insta_post_params)
    @insta_post.save
  end

  private

  def insta_post_params
    param.require(:insta_post).permit(:caption, :media_url, :timestamp)
  end
end
