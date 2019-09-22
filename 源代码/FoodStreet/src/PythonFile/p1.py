#encoding=utf-8
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

if __name__=='__main__':
    print(123)
    if len(sys.argv) > 1:
        menus = sys.argv[1]
        print(menus)
