<?php

require 'includes/aws-s3.php';
require 'vendor/autoload.php';

use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

$bucket = 'file-upload-test991';

if(isset($_FILES['fileToUpload'])) {
	$file=$_FILES['fileToUpload'];
	$name = $file['name'];
			
	$tmp_name =$file['tmp_name'];
	$extension = explode('.', $name);
	$extension = strtolower(end($extension));
					
	$key = md5(uniqid());
	$tmp_file_name = "{$key}.{$extension}";
	$tmp_file_path = "secrets/{$tmp_file_name}";
						
	move_uploaded_file($tmp_name, $tmp_file_path);

	try {
		$s3->putObject([
			'Bucket' => "{$bucket}",
			'Key' => "uploads/{$name}",
			'Body' => fopen($tmp_file_path, 'rb'),
			'ACL' => 'private'
		]);
		
		//Delete temp file
		unlink($tmp_file_path);

	} catch(S3Exception $e) {
		die("ERROR");
	}
}

?>
