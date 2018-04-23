
# 参考资料: http://blog.csdn.net/gaowg11/article/details/54910974

import pytest

def add(a, b):
    return a+b

def test_add():
    assert add(1,2) == 3