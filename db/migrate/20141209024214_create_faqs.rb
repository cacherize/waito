class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :question, limit: 512
      t.text :answer
      t.integer :sort, default: 0
      t.timestamps
    end
  end
end
