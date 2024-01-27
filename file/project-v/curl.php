<?php
if(isset($_POST['create'])){
$user= $_POST['user'];
$aktif= $_POST['aktif'];
$package= $_POST['paket'];

$ch = curl_init('http://157.230.37.167/create_account.php');
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$data = "user=$user&aktif=$aktif&paket=$package";
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
$resp = curl_exec($ch);
echo $resp;
curl_close($ch);
}
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
    <center><h3>create account</h3>

<br>
  <form action= "create_account.php" method= "post">

 <input type="text" name="user" class= "form-control" placeholder="username">
 </center>
 <br>
<input type="radio" name="aktif" value="1">&nbsp; &nbsp; Trial
&nbsp; &nbsp;
<input type="radio" name="aktif" value="30" checked="checked">&nbsp; &nbsp; 30Hari <hr>

<select class= "form-control" name= "paket">
   <option value= "flex" > set flex </option>
   <option value= "vidio" > set video </option>
   <option value= "edu" > set edu </option>
   <option value= "default" > set default </option>
</select >

    <center>
    <br>
    <input type="submit" name="create" class="btn btn-success" value="CREATE"><br>

    <br><a href="">MENU</a>
    <br></br>
  </div>
</div>
</body>
</html>

