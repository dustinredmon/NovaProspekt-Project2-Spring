<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

require 'header.php';
require 'vendor/autoload.php';
require 'aws-sts.php';

//use Aws\Sts\StsClient;
use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

$bucket = 'file-upload-test991';
$userLOG = $_SESSION['userId'];

if(isset($_FILES['fileToUpload'])) {
	$file=$_FILES['fileToUpload'];
	$name = $file['name'];
	$bucket = 'file-upload-test991';
			
	$tmp_name =$file['tmp_name'];
	$extension = explode('.', $name);
	$extension = strtolower(end($extension));
					
	$key = md5(uniqid());
	$tmp_file_name = "{$key}.{$extension}";
	$tmp_file_path = "secret/{$tmp_file_name}";
						
	move_uploaded_file($tmp_name, $tmp_file_path);

	try {
		$s3->putObject([
			'Bucket' => "{$bucket}",
			'Key' => "{$userLOG}/{$name}",

			'Body' => fopen($tmp_file_path, 'rb'),
			'ACL' => 'public-read'
		]);
		
		//Delete temp file
		unlink($tmp_file_path);

	} catch(S3Exception $e) {
		die("ERROR");
	}
}

require 'footer.php';

header("Location: ../index.php?file=fileuploadsuccess");
?>
