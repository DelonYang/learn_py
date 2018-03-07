# os

os模块功能强大，有很多系统交互的接口，不过对于path操作起来略麻烦，仅记录os常用的一些函数：

    ```python
    os.name                 #当前操作系统
    os.sep                  #分隔符
    os.linesep              #换行符
    os.getenv('')           #读取环境变量
    os.getlogin()           #当前登录的用户名
    os.getpid()             #当前进程PID
    os.system('')           #执行当前系统命令， 返回0成功、1失败
    os.abort()
    os.cpu_count()          #cpu数量
    os.kill(pid, signal)
    ```

osh中对路径的操作：

    ```python
    os.getcwd()         #当前路径
    os.chdir(path)      #切换至path
    os.chmod('dir/file', 775)  #修改权限
    os.link()                  #硬链接
    os.symlink()               #软链接
    os.listdir()               #相当于ls
    os.access(path, os.sign)      #权限测试， sign: F_OK存在? / R_OK可读? / W_OK可写? / X_OK可执行?
    os.removedirs(dir)            #删除多个文件夹，win只能删一个
    os.rmdir(dir)                 #删除单个文件夹
    os.mkdir(dir)                 #创建单个文件夹，存在会报错
    os.makedirs(dir)
    os.remove(file)               #删除文件
    os.rename('old', 'new')       #重命名

    # === DirEntry ===
    for dir in os.scandir():
        strs = dir.name  # 文件名
        strs = dir.path  # 完整路径名
        num = dir.inode()  # inode编号
        boolean = dir.is_dir()  # 是否是文件夹
        boolean = dir.is_file()  # 是否是文件
        boolean = dir.is_symlink()  # 是否是链接
        tups = dir.stat()  # 状态信息的stat_result对象
    ```

os.path中对路径的操作：

    ```python
    os.path.abspath(path)               #绝对路径
    os.path.basename(path)              #文件名
    os.path.dirname(path)               #文件夹名
    os.path.join(a, b)                  #组合路径
    dirname, filename = os.path.split(path)
    os.path.exists(path)  # 路径是否存在
    os.path.isfile(path)  # 是否是文件
    os.path.isdir(path)  # 是否是文件夹
    os.path.islink(path)  # 是否是软链接
    ```