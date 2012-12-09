import cv
import requests

capture = cv.CaptureFromCAM(0)
while True:
    im = cv.QueryFrame(capture)
    cv.SaveImage("opencv.jpg", im)
    requests.put("http://localhost:9292/streams/opencv.jpg",
            data=open('opencv.jpg', 'rb'))
