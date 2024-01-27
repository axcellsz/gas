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
