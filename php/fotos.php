<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if ($_REQUEST['image']) {
	$name_image = date("dmy_his");
	$image_parts = explode(";base64,", $_REQUEST['image']);
	$image_type_aux = explode("image/", $image_parts[0]);
	$image_type = $image_type_aux[1];
	$image_base64 = base64_decode($image_parts[1]);
	$file = '/var/www/html/sistemasmsb/public/fotos/prueba/'.$name_image.'.jpg';
	file_put_contents($file, $image_base64);
	echo $name_image;
}