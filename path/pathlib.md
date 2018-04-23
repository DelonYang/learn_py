pathlib对文件的操作

pathlib对文件夹的操作更符合面对对象的风格

    ```python
    from pathlib import Path

    path = Path()
    path.chmod(777)
    f = path.read_bytes()
    f = path.read_text(encoding='utf8')
    path.rename('newname')
    path.replace()
    path.touch()
    path.unlink()  # 删除文件/文件软链接
    path.mkdir()
    path.rmdir()

    path.exists()
    path.is_dir()
    path.is_file()
    path.is_file()
    ```