import cv
import requests

camcapture = cv.CreateCameraCapture(0)
cv.SetCaptureProperty(camcapture,cv.CV_CAP_PROP_FRAME_WIDTH, 320)
cv.SetCaptureProperty(camcapture,cv.CV_CAP_PROP_FRAME_HEIGHT, 240)
frame = cv.QueryFrame(camcapture)
cv.SaveImage("output.jpg", frame)
