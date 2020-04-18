<?php

require '../vendor/autoload.php';

use Aws\Sts\StsClient;
use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

$bucket = 'file-upload-test991';

$sts = new StsClient([
    'version' => 'latest',
    'region' => 'us-west-2'
]);
    
$sessionToken = $sts->getSessionToken();

$s3 = new S3Client([
    'region' => 'us-west-2',
    'version' => 'latest',
    'credentials' => [
        'key'    => $sessionToken['Credentials']['AccessKeyId'],
        'secret' => $sessionToken['Credentials']['SecretAccessKey'],
        'token'  => $sessionToken['Credentials']['SessionToken']
    ]
]);
 
?>
