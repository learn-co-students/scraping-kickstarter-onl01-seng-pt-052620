# require libraries/modules here
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value
#use .attribute method on Nokogiri element to grab value of attribute
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

require 'Nokogiri'
require "pry"
  def create_project_hash
    html = File.read('fixtures/kickstarter.html')
    kickstarter = Nokogiri::HTML(html)
    projects = {} #iterate through all the projects
    

    kickstarter.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text#each project title is a key, and the value is another hash with each of  
                                                          #our other data points as keys.
        projects[title.to_sym] = {:image_link => project.css("div.project-thumbnail a img").attribute("src").value,
          :description => project.css("p.bbcard_blurb").text,
          :location => project.css("ul.project-meta span.location-name").text,
          :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i}
          
          #.to_sym converts title into symbol b/c symbols, make better hash keys than strings.
      end
                                    

    projects #return projects hash
  end
  
  
    