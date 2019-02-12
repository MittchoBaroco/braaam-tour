require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  it "returns the correct summer dates when it's summer" do
    summer_start = "01-Apr-#{Date.today.year.to_s[2..4]}"
    summer_end = "31-Oct-#{Date.today.year.to_s[2..4]}"
    expect(summer_dates("2-Aug-#{Date.today.year.to_s}".to_date)).to eq([summer_start, summer_end])
  end

  it "returns the correct winter dates when it's summer" do
    winter_start = "01-Nov-#{Date.today.year.to_s[2..4]}"
    winter_end = "31-Mar-#{(Date.today.year + 1).to_s[2..4]}"
    expect(winter_dates("2-Aug-#{Date.today.year.to_s}".to_date)).to eq([winter_start, winter_end])
  end

  it "returns the correct winter dates when it's winter before the new year" do
    winter_start = "01-Nov-#{Date.today.year.to_s[2..4]}"
    winter_end = "31-Mar-#{(Date.today.year + 1).to_s[2..4]}"
    expect(winter_dates("1-Nov-#{Date.today.year.to_s}".to_date)).to eq([winter_start, winter_end])
  end

  it "returns the correct winter dates when it's winter after the new year" do
    winter_start = "01-Jan-#{Date.today.year.to_s[2..4]}"
    winter_end = "31-Mar-#{Date.today.year.to_s[2..4]}"
    expect(winter_dates("1-Jan-#{Date.today.year.to_s}".to_date)).to eq([winter_start, winter_end])
  end

  it "returns the correct summer dates when it's winter before the new year" do
    summer_start = "01-Apr-#{(Date.today.year + 1).to_s[2..4]}"
    summer_end = "31-Oct-#{(Date.today.year + 1).to_s[2..4]}"
    expect(summer_dates("1-Nov-#{Date.today.year.to_s}".to_date)).to eq([summer_start, summer_end])
  end

  it "returns the correct summer dates when it's winter after the new year" do
    summer_start = "01-Apr-#{Date.today.year.to_s[2..4]}"
    summer_end = "31-Oct-#{Date.today.year.to_s[2..4]}"
    expect(summer_dates("1-Jan-##{Date.today.year.to_s}".to_date)).to eq([summer_start, summer_end])
  end
end
