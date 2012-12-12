var express = require('express');
var app = express();

var data;

app.put('/:file', function(req, res){
  console.log('PUT ' + req.params.file);
  res.send(req.params.file);
  req.on('data', function(chunk){
    data += chunk;
  });
});

app.get('/', function(req, res){
  res.send(data);
});

app.listen(3000);

