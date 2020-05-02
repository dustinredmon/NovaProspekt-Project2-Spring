<?php

//This page is the database handler.
//The database handler is used to login and connect to the database

$servername = "terraform-20200326183430440000000002.cewoihbk0rha.us-west-2.rds.amazonaws.com";
$dBUsername = "admin";
$dBPassword = "MASTERpassword1199";
$dBName = "nova_prospekt";
$dBPort = "3306";

$conn = mysqli_connect($servername, $dBUsername, $dBPassword, $dBName, $dBPort);

if (!$conn) {
  die("Connection failed: ".mysqli_connect_error());
}
