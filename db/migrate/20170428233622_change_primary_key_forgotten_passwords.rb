class ChangePrimaryKeyForgottenPasswords < ActiveRecord::Migration[5.1]
  def change
    rename_column :forgotten_passwords, :hash, :hash_pk
  end
end
