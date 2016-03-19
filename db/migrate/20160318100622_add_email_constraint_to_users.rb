class AddEmailConstraintToUsers < ActiveRecord::Migration
  def up
    execute %{
      ALTER TABLE
        users
      ADD CONSTRAINT
        email_must_be_company_email
      CHECK ( email ~* '^[^@]+@[porthoshome|antiquerevival]+\\.com' AND admin=TRUE )
    }
  end
  def down
    execute %{
      ALTER TABLE
        users
      DROP CONSTRAINT
        email_must_be_company_email
    }
  end
end


alter table if exists node_access add constraint chk_block_anonymous_page_edit check (gid <> 1 or realm <> 'nodeaccess_rid' or grant_update = 0 or grant_delete = 0);