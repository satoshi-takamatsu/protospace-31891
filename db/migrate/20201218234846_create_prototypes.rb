class CreatePrototypes < ActiveRecord::Migration[6.0]
  def change
    create_table :prototypes do |t|
      # title,catch_copy,conceptのカラムを追加
      t.string :title,        null: false
      t.text :catch_copy,     null: false
      t.text :concept,        null: false
      # 外部制約キーの記述 DBではuser_idカラムが生成させる
      t.references :user,     foreign_key: true
      t.timestamps
    end
  end
end

# migrationファイルを編集する時は、down状態にすることを忘れないように！