class StaticPagesController < ApplicationController
  def about
    @active_nav = 'about'
  end

  def health_check
    render inline: '<!DOCTYPE html><html><body><h1>¯\\_(ツ)_/¯</h1></body></html>'
  end
end

