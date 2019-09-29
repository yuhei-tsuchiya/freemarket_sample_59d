lady = Burden.create(:name=>"送料込み（出品者負担）")

lady.children.create(:name=>"未定")
lady.children.create(:name=>"らくらくメルカリ便")
lady.children.create(:name=>"ゆうメール")
lady.children.create(:name=>"普通郵便（定型、、定形外）")
lady.children.create(:name=>"クロネコヤマト")
lady.children.create(:name=>"ゆうパック")
lady.children.create(:name=>"クリップポスト")
lady.children.create(:name=>"ゆうパケット")

men = Burden.create(:name=>"着払い（購入者負担）")

men.children.create(:name=>"未定")
men.children.create(:name=>"クロネコヤマト")
men.children.create(:name=>"ゆうパック")
men.children.create(:name=>"ゆうメール")