class CreateRequestedshifts < ActiveRecord::Migration
  def self.up
    create_table :requestedshifts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :requestedshifts
  end
end
