<?php

?>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>im3</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style type="text/css">
    #wrapshopcart{width:310px;margin:auto;padding:50px;
     padding-bottom: 2px;margin-bottom: 20px;background:#fff;box-shadow:0 0 5px #c1c1c1;border-radius:5px;}
    #response{
        text-align: center;
    }
    #EE{
        width: 50%;
    }
    textarea { resize:none; }
    #count{
        text-align: right;
    }
</style>
</head>
<body>

  <br><div id="wrapshopcart">
    <center><h2>BUAT VMESS</h2><br>
    
  <form action= "create_account.php" method= "post">
  
    <input type="text" name="user" class= "form-control" placeholder="username"><br>
    
    <input type="number" name="aktif" class= "form-control" placeholder="masa aktif"><br>
    
    <input type="submit" name="create" class="btn btn-success" value="CREATE"><br>
    
    <br><a href="">MENU</a>
    <br></br>
  </div>
</div>
</body>
</html>
