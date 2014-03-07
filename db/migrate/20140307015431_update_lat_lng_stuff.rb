class UpdateLatLngStuff < ActiveRecord::Migration
  def change
    remove_column :places, :lat
    remove_column :places, :lng
  end
end
