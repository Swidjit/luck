 class SitemapController < ApplicationController
   def index
     @static_pages = [pages_url("how_it_works")]
     @games = Game.all
     respond_to do |format|
       format.xml
     end
   end
 end