import cv
import os

capture = cv.CaptureFromCAM(0)
while True:
    im = cv.QueryFrame(capture)
    cv.SaveImage("opencv.jpg", im)
    os.system("curl -T opencv.jpg http://localhost:9292/streams/")
