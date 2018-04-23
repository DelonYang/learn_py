import fire

def foo(name, age=10):
    print(type(name), type(age))
    return name, age

def main():
    fire.Fire(foo)

if __name__ == '__main__':
    main()