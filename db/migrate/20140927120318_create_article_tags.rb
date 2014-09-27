class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :article_tags do |t|
      t.references :article_id, index: true
      t.references :tag_id, index: true

      t.timestamps
    end
  end
end
