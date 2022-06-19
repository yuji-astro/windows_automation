import pyautogui
import time
import sys
import tkinter

def main(interval,pos_x=None,pos_y=None):
    try:
        while True:
            time.sleep(interval)
            pyautogui.click(x=pos_x, y=pos_y)
            print("I clicked at " + str(pyautogui.position()))
        
    except KeyboardInterrupt:
        print("Ctrl + C was commanded!! programm stoped")

if __name__ == '__main__':
    args = sys.argv
    if len(args) <= 2:
        if args[1].isdigit():
            main(int(args[1]))
        else:
            print('Argument is not digit')
    elif 2 < len(args) and len(args) <= 4 :
        main(int(args[1]),int(args[2]),int(args[3]))
    else:
        print('Arguments are too long')
