import cv
import requests

camera = 0
put = 'http://localhost:9292/streams/'
stream_id = 'opencv'
filetype = 'jpg'

capture = cv.CaptureFromCAM(camera)
while True:
    im = cv.QueryFrame(capture)
    cv.SaveImage("%s.%s" % (stream_id, filetype), im)
    requests.put("%s/%s.%s" % (put, stream_id, filetype),
#            data=im.tostring())
            data=open("%s.%s" % (stream_id, filetype), 'rb'))
