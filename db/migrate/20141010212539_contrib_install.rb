class ContribInstall < ActiveRecord::Migration
  def up
    enable_extension "fuzzystrmatch"
    enable_extension "pg_trgm"
  end

  def down
    disable_extension "fuzzystrmatch"
    disable_extension "pg_trgm"
  end
end
