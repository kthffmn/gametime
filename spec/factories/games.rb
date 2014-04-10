# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    instructions "MyString"
    maximum 1
    minimum 1
    early_childhood false
    elementary_school false
    middle_school false
    high_school false
    college false
    adulthood false
  end
end
