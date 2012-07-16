#!/bin/sh

HOST=http://www.pauljohninternetart.info

echo "Please enter a name for this stream:"
read STREAM

STREAM=$(echo $STREAM | sed 's/[^A-Za-z]//g')
PASSWORD=$(curl ${HOST}/create/${STREAM})

echo "You can watch this stream at ${HOST}/watch/${STREAM}"

while [ 1 ]
do
  ./wacaw ${STREAM}
  curl -T ${STREAM}.jpeg ${HOST}/update/${STREAM} -u ${STREAM}:${PASSWORD}
done
