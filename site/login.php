<?php
session_start();
include 'koneksi.php';

if (isset($_POST['login'])){
  $username = $_POST['user'];
  $password = $_POST['pass'];

  $_SESSION['login'] = $_POST['login'];
  
  $ambil = mysqli_query($con,"SELECT * FROM user WHERE username = '$username'");

  if (mysqli_num_rows($ambil) === 1){
    $data = mysqli_fetch_assoc($ambil);
  if (password_verify($password,$data['password'])){
      $_SESSION['nama'] = $data['nama'];
      $_SESSION['username'] = $data['username'];
      header("location:index.php");
      exit();
    }else {
      echo "<script>
      alert('username atau password salah');
      window.location = 'login.php';
      </script>";
  }
  
  }else {
    echo "<script>
    alert('username atau password salah');
    window.location = 'login.php';
    </script>";
  }
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
    <center><h2>Login</h2><br>
  <form action= "" method= "post">
    <input type="text" name="user" class= "form-control" placeholder="Username"><br>
    <input type="password" name="pass" class= "form-control" placeholder="Password"><br>
    <input type="submit" name="login" class="btn btn-success" value="login"><br>
    <br><a href="registrasi.php">Register</a><br>
    <br></br>
  </div>
</div>
</body>
</html>
