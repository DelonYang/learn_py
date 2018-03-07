### 1. 搭建svn服务器
1. 安装subversion

    ```shell
    sudo apt-get install subversion
    ```
2. 建仓库

    ```shell
    mkdir /data/svn
    snvadmin create /data/svn/project
    ```
3. 修改设置`svnserve.conf `, `passwd`, `authz`

    ```shell
    #svnserve.conf
    #匿名访问的权限，可以是read,write,none,默认为read 
    anon-access = none
    #认证用户的权限，可以是read,write,none,默认为write 
    auth-access = write 
    password-db = passwd
    authz-db = authz

    #passwd
    user = passwd

    #authz
    [groups]
    admin=user1, user2

    [\]
    @admin=rw
    ```
4. 设置5个字符以上才能commit

    ```shell
    #修改hooks
    REPOS="$1"  
    TXN="$2"  
    SVNLOOK=/usr/bin/svnlook  
    LOGMSG=`$SVNLOOK log -t $TXN $REPOS | wc -m`
    if [ "$LOGMSG" -lt 5 ] 
    then
    echo "Enter at least 5 characters." >&2
    exit 1
    fi
    exit 0
    ```

5. 启动svn

    ```
    svnserve -d -r /data/svn
    #添加至开机启动
    将启动命令添加至`/etc/rc.local`， 不过要添加在`exit 0` 前面
    ```

### 2. Git相关

1. 不用每次commit都输密码 `git config --global credential.helper store`


### 3. 数据库相关

1. 添加

    ```sql
    #1. 添加新字段
    alter table hash_profit add column order_id  int(11) NOT NULL;
    #2. 添加索引
    ALTER TABLE hash_profit ADD INDEX order_id(order_id);
    #3. 添加外键约束
    alter table hash_profit add constraint hash_profit_ibfk_3 foreign key(order_id) REFERENCES star_contract_order(id)

    #1. 导入导出
    mysqldump -hhostname -uusername -ppassword databasename > backupfile.sql
    mysql -hhostname -uusername -ppassword databasename < backupfile.sql

    #1. 用户授权
    GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION; 
    FLUSH PRIVILEGES; 
    ```

### 4. linux设置
1. ssh远程免密码登录

    ```
    ssh-keygen生成密钥
    ssh-copy-id user@host 拷贝到对应主机
    ```
2. 改为静态IP

    ```
    vi /etc/network/interfaces

    auto eth1
    iface eth1 inet static
    address 192.168.0.138
    netmask 255.255.255.0
    gateway 192.168.0.1
    dns-nameservers 8.8.8.8
    ```
3. 以前kill所有相关进程

    ```
    ps aux|grep server|grep -v grep | awk '{print $2}'|xargs kill -9
    ```
4. ubuntu开启root界面登录

    ```
    sudo vim /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
    [SeatDefaults]
	autologin-user=root
	user-session=ubuntu
	greeter-show-manual-login=true

    vi /root/.profile
    将mesg n替换成tty -s && mesg n
    ```