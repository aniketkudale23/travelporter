class AddPasswordDigestToProviders < ActiveRecord::Migration[5.1]
  def change
    add_column :providers, :password_digest, :string
  end
end
