import tkinter as tk
import threading
import time
import pyautogui


def get_pos(root,cur_pos):
    pos = pyautogui.position()
    cur_pos.set(pos)

    root.after(5, lambda : get_pos(root,cur_pos))

def start(interval,x_pos,y_pos):
    thread = threading.Thread(target=click, args = (interval,x_pos, y_pos))
    thread.start()

def click(interval,x_pos,y_pos):
    global flg
    print("動作をスタートします。")
    if x_pos == 0 and y_pos == 0:
        x_pos=None
        y_pos=None
    while 1:
        if flg == False:
            print("動作を途中停止します。")
            flg = True
            break
        else:
            time.sleep(interval)
            pyautogui.click(x_pos,y_pos)
            print("I clicked at " + str(pyautogui.position()))

def stop():
    global flg
    flg = False

root = tk.Tk()
root.title("周期的クリックツール")
# ここでウインドウサイズを定義する
root.geometry('750x250')

flg = True

#ウィジェット1
label1 = tk.Label(root, text = '現在のカーソル位置x,y[pixel]:')
cur_pos = tk.StringVar()
label_cur_pos = tk.Label(root,textvariable=cur_pos)
label1.grid(row=0,column=0)
label_cur_pos.grid(row=0,column=1)

#ウィジェット2
label2 = tk.Label(root, text = 'クリック時間間隔[s] (Required):')
click_time = tk.DoubleVar()
label_click_time = tk.Entry(root,textvariable=click_time)
label2.grid(row=1,column=0)
label_click_time.grid(row=1,column=1)

#ウィジェット3
label3 = tk.Label(root, text = 'クリックxy座標[pixel] (Optional):')
click_x_pos = tk.IntVar()
click_y_pos = tk.IntVar()
label_click_x_pos = tk.Entry(root,textvariable=click_x_pos)
label_click_y_pos = tk.Entry(root,textvariable=click_y_pos)
label3.grid(row=2,column=0)
label_click_x_pos.grid(row=2,column=1,sticky=tk.EW)
label_click_y_pos.grid(row=2,column=2,sticky=tk.EW)

btn1 = tk.Button(text="実行",command=lambda:start(click_time.get(),click_x_pos.get(),click_y_pos.get()))
btn1.grid(row=3,column=1)

btn2 = tk.Button(text="停止",command=stop)
btn2.grid(row=4,column=1)

# root.grid_columnconfigure(1, weight=1) # 列の調整

root.after(5, lambda : get_pos(root,cur_pos))
root.mainloop()