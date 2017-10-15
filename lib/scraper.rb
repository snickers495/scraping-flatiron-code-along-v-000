require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  @@array = []
    def get_page
      html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
      doc = Nokogiri::HTML(html)
      doc
    end

    def get_courses
      self.get_page.css(".post")
    end

    def make_courses
      self.get_courses.each do |course|
        title = course.css("h2").text
        schedule = course.css(".date").text
        description = course.css("p").text
        Course.new(title, schedule, description)
      end
    end

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end
