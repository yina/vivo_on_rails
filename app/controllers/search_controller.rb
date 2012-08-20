
class SearchController < ApplicationController
  def search_by_faculty_member
    q = params[:q].strip
    render :text => "Invalid query. Query string is blank. Please go back and input a query." if q.blank? or q.nil?
    
    @search = FacultyMember.search do
      keywords q do
        fields(:last_name, :first_name)
      end
    end
    
    render :text => "No hits" if @search.total.eql? 0
    
  end
  
  def search_by_academic_article_keyword
    q = params[:q].strip
    render :text => "Invalid query. Query string is blank. Please go back and input a query." if q.blank? or q.nil?

    @search = AcademicArticle.search do
      keywords q do
        fields(:label, :abstract)
      end
      facet :authorship
    end
    
    render :text => "No hits" if @search.total.eql? 0
    
  end
  
end
