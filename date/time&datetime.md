## time

相关函数和属性：

    ```python
    1. process_time() #返回当前进程所消耗的处理器运行时间秒数（不包括sleep时间）
    2. ctime(t) #时间戳 -> 字符串， t默认:time.time()
    3. asctime(t) #struct_time -> 字符串, t默认：time.localtime()
    4. localtime(), gmtime() 返回struct_time
    5. mktime() #struct_time -> timestamp
    6. strftime(), strftime() # struct_time <-> str
    7. sleep()
    ```

`timestamp`与`str`不能直接转，`struct_time`就是一个中间层，对时间戳进行加减，然后通过`localtime() -> struct_time -> strftime()`

## datetime

|class|description|
|--|--|
|date|日期|
|time|时间|
|datetime|××|
|timedelta|时间间隔|
|tzinfo|时区相关|

### date
常用方法：

|属性|description|
|--|--|
|today()|返回本地当前日期|
|fromtimestamp(timestamp)|根据跟定的时间戳，返回一个date对象|
|year、month、day|年月日|
|d.timetuple()|返回d对应的time_struct|
|d.weekday(),d.isoweekday()|返回星期几、起始不一样,iso从1开始|
|d.isoformat()|返回‘YYYY-MM-DD’格式的日期字符串|
|d.strftime(format)|返回str|


### time

time类与date相似，常用的方法就是t.isoformat(), t.strftime()

### datetime
|属性|description|
|--|--|
|today()|返回datetime对象|
|now(tz)|可以指定相应时区|
|fromtimestamp(timestamp)|通过指定时间戳创建datetime对象|
|strptime()|str -> datetime|
|d.date(), d.time()|..|
|d.timestamp()|dt -> timestamp|

### timedelta

timedelta(days=-1) + datetime.today()
