# Setting up a stream client

*Please note: this client/capture combination only works with OS X, but anyone
can play along with [curl](http://curl.haxx.se/). See instructions further
down the page.*

## Step 1: Downloading files

Save the following files somewhere on your computer:

  * [wacaw](/wacaw), a tool for capturing images from a camera on OS X
  * [stream](/stream), the command-line client

## Step 2: Make the files executable

Open a Terminal window (Applications -> Utilities -> Terminal). Change to the
directory where you just downloaded those two files, e.g.:

    cd /Users/Timothy/Downloads

Make the files executable:

    chmod u+x stream wacaw

## Step 3: Start broadcasting

    ./stream

When you start the client, it will prompt you for a stream name; if the stream
is created successfully your iSight should start snapping away wildly!

# Using `curl` alone

If you don't have a Mac, or want to use a different application to capture
images, here's how you would broadcast a stream using `curl`:

## Create a new stream

    curl http://www.pauljohninternetart.info/create/hungadunga

If this is successful, it will return the password for the new stream. Stream
names can only contain letters (uppercase and lowercase) A-Z.

## Update an image

Say you have saved an image from your webcam called `capture.jpg` and you wanted
to update a stream called `hungadunga` and a password of `beansprout`:

    curl -T capture.jpg http://www.pauljohninternetart.info/update/hungadunga -u hungadunga:beansprout

