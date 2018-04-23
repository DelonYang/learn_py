常用包和函数：
1. itertools
    1. chain
        ```python
        test_list = [[1,2],[3,4]]
        chain.from_iterable(test_list)
        chain(*test_list)
        ```
2. 使用and or 代替三目运算
    ```python
    1 == 1 and a or b
    1 == 2 and a or b
    ```
3. pyftpdlib
    一行命令开启ftp服务，在需要共享的目录使用该命令：`python - m pyftpdlib -p 21`

4. logging常用配置
    ```python
    import logging
    #设置format， 文件名，及日志级别
    logging.basicConfig(filename='tt.log', level=logging.DEBUG, format='[%(asctime)s] %(filename)s : %(levelname)s  %(message)s')
    ```
5. 限制递归深度
    ```python
    def tt():
      for _ in range(5):
        if tt():
          break
    ```
6. 使用tenacity进行函数retry
    ```python
    from tenacity import retry
    from random import randint

    @retry
    def tt():
        i = randint(1,10)
        if i < 8:
            print('error i={}'.format(i))
            raise RuntimeError(i)
        else:
            print('ok={}'.format(i))
    ```

    `retry`的常用参数：
    1. 尝试n次
      ```python
      from tenacity import *
      @retry(stop=stop_after_attempt(n))
      def xxx:
      ...
      ```
    2. 一定时间后退出
      ```python
      @retry(stop=stop_after_delay(s))
      ```
    3. 二者都有
      ```python
      @retry(stop=(stop_after_attempt(n) | stop_after_delay(s)))
      ```
    4. 等待一定时间后重试
      ```python
      @retry(wait=wait_fixed(s))
      ```
    参考资料：
    [pypi](https://pypi.python.org/pypi/tenacity)
    [blog文档](https://kingname.info/2017/06/18/easy-retry/)

7. defaultdict类型的使用， 主要处理缺省key默认值的情况

    `defaultdict`使用一个函数去初始化，当使用`d[key]`形式取值的时候，即触发该函数，返回其值。

    原理就是，继承dict， 重写其`__missing__`方法

    ```python
    from collections import defaultdict
    d = defaultdict(lambda: 0)
    d[key]
    d.get() #不能触发lambda函数
    ```
