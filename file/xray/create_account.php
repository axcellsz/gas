<?php

$user= $_POST['user'];
$aktif= $_POST['aktif'];
$package= $_POST['paket'];
echo $user, " ", $aktif, " ", $package; 

switch ($package){
case "flex":
 $pilot = "web-flex";
 break;
 case "vidio":
 $pilot = "web-vidio";
 break;
 case "edu":
 $pilot = "web-edu";
 break;
 case "default":
 $pilot = "web-default";
 break;
}

$path1 = 'user';
$path2 = 'aktif';

$fh1 = fopen($path1,"w");
$fh2 = fopen($path2,"w");

fwrite($fh1,$user);
fwrite($fh2,$aktif);

    fclose($fh1);
    fclose($fh2); 
    
$output = shell_exec('sh '.$pilot.'');

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
                .inr { 
            text-align: center;
            height: 300px; 
            width:  200px; 
            color: #3498db; 
            font-size: 0.5em; 
            border: 1px solid #3498db; 
            
        } 
    
    
</style>
</head>
<body>

  <br><div id="wrapshopcart">
    <center><h2>Ax-Ray Conf</h2><br>
<form method= "post" action= "">    
<center><textarea class="inr" id="conf" type="textarea" style="text-align: center;" readonly><?PHP echo ($output)?></textarea><br>
 <br>   
<span class=mono id="theList">

</span>
<button id="copyButton" onclick="Copy()" name= "klik" class="btn btn-success">Salin Config</button><br>
<br>
<script>
function Copy() {
  var Text = document.createElement("textarea")
  Text.value = document.getElementById("conf").innerHTML;
  Text.value = Text.value.replace(/&lt;/g,"<");
  Text.value = Text.value.replace(/&gt;/g,">");
  document.body.appendChild(Text)
  Text.focus();
  Text.select();
  document.execCommand('copy');
  document.body.removeChild(Text);
}
</script>
 

</div>
</body>
</html>

 <?php
if (isset($_POST['klik'])) {
echo "<script>
alert('Config berhasil di salin');
window.location = 'index.php';
</script>";
}
?>
