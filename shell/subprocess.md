#subprocess

subprocess用户执行shell命令，部分操作也可以在win上执行，替代原`os.system`，`command`相应模块。

使用方法：

1. `subprocess.run()`是模块核心函数，很多命令其实都执行了它。

    ```python
    subprocess.run(['df','-h'])
    subprocess.run('df -h | grep sda1', shell=True) #shell=True是指不需要Python解析，直接把字符串给shell
    ```
2. 常用方法

    ```python
    subprocess.call(['ls','-l']) # 成功返回0，不成功返回非0
    subprocess.check_call(['ls','-l']) # 执行成功返回0，执行错误抛异常
    subprocess.getoutput('ls /bin/ls') # 接收字符串格式命令，只返回结果
    subprocess.check_output(['ls','-l']) #执行成功返回执行结果，不成功出错
    subprocess.getstatusoutput('ls /bin/ls') #返回元祖(1,'/bin/ls')，第一个状态，第二个结果
    ```
    上面的方法，底层都是封装subprocess.Popen， 通过Popen对象来操作shell
3. Popen

    ```python
    from subpeocess import PIPE
    #PIPE指通过管道去与shell通信，每次执行Popen，都是新建一个shell，进程间通信，应用PIPE
    p = subprocess.Popen('shell命令', shell=True, stdout=PIPE， stdin=PIPE, stderr=PIPE)
    p.stdout.read() #读取输出
    p.stdin.write('') #输入
    ```
