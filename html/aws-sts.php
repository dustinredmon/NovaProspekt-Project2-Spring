<?php

use Aws\S3\S3Client;

require 'vendor/autoload.php';

$config = require('config.php');

$s3 = S3Client::factory([
	'version' => 'latest',
	'region' => 'us-west-2',
	'key' => $config['s3']['key'],
	'secret' => $config['s3']['secret']
	
]);

?>
