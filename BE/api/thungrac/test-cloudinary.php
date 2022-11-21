
<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: *");
include_once ("../vendor/autoload.php");
use Cloudinary\Configuration\Configuration;
use Cloudinary\Api\Upload\UploadApi;
// configure globally via a JSON object


Configuration::instance([
  'cloud' => [
    'cloud_name' => 'cosmeticv1', 
    'api_key' => '128838644673239', 
    'api_secret' => 'Yfr5A065pD24L06Ke6QztwOFw8Y'],
  'url' => [
    'secure' => true]]);
$data = (new UploadApi())->upload($_FILES['sendimage']['tmp_name'], [
  'folder' => 'myfolder/mysubfolder/', 
  'public_id' => 'product1', 
  'overwrite' => true, 
  'resource_type' => 'image']);
echo json_encode($data['secure_url']);
?>