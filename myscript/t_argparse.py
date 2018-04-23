import argparse

def main():
    parser = argparse.ArgumentParser(description='test argparse')
    parser.add_argument('--name', type=str)
    parser.add_argument('--tt', type=int, default=32)
    args = parser.parse_args()
    print(args)
    print(args.tt)

if __name__ == '__main__':
    main()