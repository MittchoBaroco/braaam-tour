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
    summer_start = "01-Apr-18"
    summer_end = "31-Oct-18"
    expect(summer_dates("2-Aug-2018".to_date)).to eq([summer_start, summer_end])
  end

  it "returns the correct winter dates when it's summer" do
    winter_start = "01-Nov-18"
    winter_end = "31-Mar-19"
    expect(winter_dates("2-Aug-2018".to_date)).to eq([winter_start, winter_end])
  end

  it "returns the correct winter dates when it's winter before the new year" do
    winter_start = "01-Nov-19"
    winter_end = "31-Mar-20"
    expect(winter_dates("1-Nov-2019".to_date)).to eq([winter_start, winter_end])
  end

  it "returns the correct winter dates when it's winter after the new year" do
    winter_start = "01-Jan-20"
    winter_end = "31-Mar-20"
    expect(winter_dates("1-Jan-2020".to_date)).to eq([winter_start, winter_end])
  end

  it "returns the correct summer dates when it's winter before the new year" do
    summer_start = "01-Apr-20"
    summer_end = "31-Oct-20"
    expect(summer_dates("1-Nov-2019".to_date)).to eq([summer_start, summer_end])
  end

  it "returns the correct summer dates when it's winter after the new year" do
    summer_start = "01-Apr-20"
    summer_end = "31-Oct-20"
    expect(summer_dates("1-Jan-2020".to_date)).to eq([summer_start, summer_end])
  end
  #
  # it "return the correct summer dates when it's summer" do
  #   summer_start = "01-Apr-#{Date.today.year.to_s[2..4]}"
  #   summer_end = "30-Oct-#{Date.today.year.to_s[2..4]}"
  #   expect(summer_dates("2-Aug-2018".to_date)).to eq([summer_start, summer_end])
  # end
  #
  # it "return the correct winter dates when it's summer" do
  #   winter_start = "01-Nov-#{Date.today.year.to_s[2..4]}"
  #   winter_end = "30-Mar-#{(Date.today.year + 1).to_s[2..4]}"
  #   expect(winter_dates("2-Aug-2018".to_date)).to eq([winter_start, winter_end])
  # end
  #
  # it "return the correct winter dates when it's winter" do
  #   winter_start = "01-Nov-#{Date.today.year.to_s[2..4]}"
  #   winter_end = "30-Mar-#{(Date.today.year + 1).to_s[2..4]}"
  #   expect(winter_dates("1-Jan-2019".to_date)).to eq([winter_start, winter_end])
  # end
  #
  # it "return the correct summer dates when it's winter" do
  #   summer_start = "01-Apr-#{(Date.today.year + 1).to_s[2..4]}"
  #   summer_end = "30-Oct-#{(Date.today.year + 1).to_s[2..4]}"
  #   expect(summer_dates("1-Jan-2019".to_date)).to eq([summer_start, summer_end])
  # end
  #
  # it "returns the correct season when it's summer" do
  #   expect(season("1-Aug-2018".to_date)).to eq(:summer)
  # end
  #
  # it "returns the correct season when it's winter" do
  #   expect(season("1-Jan-2019".to_date)).to eq(:winter)
  # end
end
