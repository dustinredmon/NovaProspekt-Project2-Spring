<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

require 'header.php';
require 'vendor/autoload.php';

use Aws\Sts\StsClient;
use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

$bucket = 'file-upload-test991';

$s3 = new S3Client([
	    'region' => 'us-west-2',
	        'version' => 'latest',
		    'credentials' => [
			'key'    => 'AKIA5J45A2YBGY6J3V6W',
	                'secret' => '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'	
		]
	]);

$objects = $s3->getIterator('ListObjects', [
	'Bucket' => $bucket,
	


]);




require 'footer.php';

?>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>File List</title>
	</head>
	<body>
		<table>
			<thead>
				<tr>
					<th>File</th>
					<th>Download</th>
				</tr>
			</thead>
			<tbody>
				<?php foreach($objects as $object): ?>
				<tr>
					<td><?php echo $object['Key']; ?></td>
					<td><a href="<?php echo $s3->getObjectUrl($bucket, $object['Key']); ?>" download="<?php $object['Key']; ?>">Download</td>
				</tr>
				<?php endforeach; ?>
			</tbody>
		</table>
	
	</body>
</html>
