/* rootのパスワードを設定します。 */
set password for root@localhost=password('password');
/* hoge というユーザを新規に作成します。のパスワードも設定します。 */
insert into user set user="wpuser", password=password("wppassword"), host="localhost";
/* wpdb というwordpress用にデータベースを作成します。 */
create database wpdb;
/* wpdb というデータベースに wpuserというユーザが常にアクセスできるようにします。 */
grant all on wpdb.* to wpuser;
/* 最新に更新 */
FLUSH PRIVILEGES;
