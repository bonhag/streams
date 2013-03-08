import cv
import os


stream = 'raspberrypitesting'

camcapture = cv.CreateCameraCapture(0)
cv.SetCaptureProperty(camcapture,cv.CV_CAP_PROP_FRAME_WIDTH, 320)
cv.SetCaptureProperty(camcapture,cv.CV_CAP_PROP_FRAME_HEIGHT, 240)

while True:
	frame = cv.QueryFrame(camcapture)
	cv.SaveImage("%s.jpg" % stream, frame)

	# Post to stream
	os.system("curl -T %s.jpg http://www.pauljohninternetart.info/update/%s" % (stream, stream))
