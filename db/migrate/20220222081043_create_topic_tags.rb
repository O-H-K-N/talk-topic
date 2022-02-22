class CreateTopicTags < ActiveRecord::Migration[7.0]
  def change
    create_table :topic_tags do |t|
      t.references :topic, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
    add_index :topic_tags, [:topic_id, :tag_id], unique: true
  end
end
