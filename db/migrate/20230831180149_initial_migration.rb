class InitialMigration < ActiveRecord::Migration[7.0]
  def change
    enable_extension :citext

    create_table :users do |t|
      t.citext :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.integer :last_otp_at
      t.timestamps
    end

    create_table :sessions do |t|
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.string :user_agent, :ip_address, null: false
      t.timestamps
    end

    create_table :documents do |t|
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.timestamps
    end
  end
end
