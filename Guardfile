# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: "APP_ENV=test bundle exec rspec" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^(endpoints)/.+_rb$}) { |m| "spec/#{m[1]}/#{m[2]}_spec.rb" }
end