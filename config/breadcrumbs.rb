crumb :root do
  link "Home", root_path
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).


# ルート
crumb :root do
  link "メルカリ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", root_path
  parent :root
end

#
crumb :card do
  link "支払い方法",root_path
  parent :root
end

crumb :profile do
  link "プロフィール", root_path
  parent :root
end

crumb :user_registe do
  link "本人情報の登録", root_path
  parent :root
end

crumb :log_out do
  link "ログアウト", root_path
  parent :root
end

# 商品カテゴリー
@categories = Category.all
@categories.each do |cat|
  if cat.depth == 1
    crumb :"item#{cat.id}" do
      link cat.name, "/items/category/#{cat.id}"
      parent :root
    end
  else
    crumb :"item#{cat.id}" do
      link cat.name, "/items/category/#{cat.id}"
      parent :"item#{cat.parent.id}"
    end
  end
end

