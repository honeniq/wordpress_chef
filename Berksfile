site :opscode

cookbook "mysql"
cookbook "php"
#cookbook "apache2"
cookbook "nginx"
cookbook "git"
cookbook "vim"

# vagrant-berkshelfを使うと「chef.cookbooks_path」が乗っ取られるので、
# 自作レシピは個別にパス指定が必要
cookbook 'wordpress', path: './site-cookbooks/wordpress'