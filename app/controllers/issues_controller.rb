class IssuesController < ApplicationController
  # GET /issues
  # GET /issues.json
  def index
    if params[:filter] == "open"
      @issues = Issue.open
    elsif params[:filter] == "rejected"
      @issues = Issue.rejected
    elsif params[:filter] == "closed"
      @issues = Issue.closed
    else
      @issues = Issue.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = Issue.find(params[:id])
    @athlete_issues = { open: Issue.open.where(athlete_id: @issue.athlete_id).count, 
      closed: Issue.closed.where(athlete_id: @issue.athlete_id).count, 
      rejected: Issue.rejected.where(athlete_id: @issue.athlete_id).count
      }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end
  
  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end
end
