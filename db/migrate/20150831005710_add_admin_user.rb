class AddAdminUser < ActiveRecord::Migration

  def up
    User.create!(email: 'admin@admin.com', password: 'admin', admin: '1')
  end

  def down
    user = User.find_by_email 'admin@admin.com'
    user.destroy!
  end
end
