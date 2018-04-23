### 1. 搭建svn服务器
1. 安装subversion

    ```shell
    sudo apt-get install subversion
    ```
2. 建仓库

    ```shell
    mkdir /data/svn
    svnadmin create /data/svn/project
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

    [/]
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
    ALTER TABLE table_name ADD COLUMN order_id  INT(11) NOT NULL;
    #2. 添加索引
    ALTER TABLE table_name ADD INDEX order_id(order_id);
    #3. 添加外键约束
    ALTER TABLE table_name ADD CONSTRAINT hash_profit_ibfk_3 foreign key(order_id) REFERENCES star_contract_order(id)
    #4. 设置自增id从n开始，n为下次添加时的值
    ALTER TABLE table_name AUTO_INCREMENT=n

    #1. 导入导出
    mysqldump -hhostname -uusername -ppassword databasename > backupfile.sql
    mysql -hhostname -uusername -ppassword databasename < backupfile.sql

    #1. 用户授权
    GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION; 
    FLUSH PRIVILEGES; 

    #1. 复制表
    CREATE TABLE 新表 SELECT * FROM 旧表 会连同数据一起复制
    CREATE TABLE 新表 SELECT * FROM 旧表 WHERE 1=2 只复制表结构
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

5. ubuntu命令行开热点
    使用create_ap管理热点

    1. 安装`create_ap`

        ```shell
        apt-get install build-essential linux-headers-generic dkms git
        apt-get remove hostapd
        apt-get install hostapd

        git clone https://github.com/oblique/create_ap
        cd create_ap
        make install
        ```
    2. `create_ap`常用命令

        ```shell
        //1. 开启热点
        create_ap 无线网卡 有线网卡 wifi名 密码 --daemon --dhcp-dns 114.114.114.114
        
        //2. 关闭
        create_ap --stop 无线网卡

        //option
        --list-running          返回开启中的热点
        --deamon                后台运行
        ```
6. 搭建samba文件共享服务

    ubuntu安装比较简单，可以使用tasksel安装；centos安装：`yum install samba samba-client samba-swat`

    **配置samba**

    1. 在系统中添加相应共享用户

        ```shell
        groupadd pp -g 6000
        useradd pp -u 6000 -g 6000 -s /sbin/nologin -d /dev/null
        //该用户不能登录，只是作为samba服务用的
        ```
    2. 添加相应的samba账户

        ```shell
        pdbedit -a pp
        ```
    3. 配置smb.conf文件

        ```shell
        [public]
        comment = public
        path = /var/tmp
        public = no
        writable = yes
        write list = +pp
        ```
    4. 重载smb

        ```shell
        service smb reload
        ```
    参考资料：[samba相关配置](http://www.cnblogs.com/mchina/archive/2012/12/18/2816717.html)

7. 获取mac地址的几种办法：

    1. 使用`ifconfig`，然后从中匹配相应字符串
    2. 使用`lshw -c network | grep serial`, 而后匹配
    3. 用python获取：

        ```python
        from uuid import getnode
        imac = getnode()
        mac = ':'.join(f'{imac:012X}'[n: n+2] for n in range(0, 12, 2))
        ```

8. 修正Linux网卡名

    ```shell
    vi /etc/default/grub
    改：GRUB_CMDLINE_LINUX="" 为 GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"
    grub-mkconfig -o /boot/grub/grub.cfg
    #重启生效
    ```
    **注意：修正后要改interface配置，网卡名对不上不能联网！！！**

# 杂项
1. pip更换源：
    1. 临时更换：`pip -i https://pypi.douban.com/simple install Flask -- trusted-host pypi.douban.com`
    2. 更新配置文件：
        1. win, 新建~/pip/pip.ini文件
        2. linux, 新建~/.pip/pip.conf文件

            同时添加以下内容：
            ```
            [global]
            trusted-host=mirrors.aliyun.com
            index-url=http://mirrors.aliyun.com/pypi/simple/
            ```