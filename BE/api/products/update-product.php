<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

//import file
include_once "../database/database.php";
include_once("../vendor/autoload.php");
include_once "../middleware/check-auth.php";

use Cloudinary\Configuration\Configuration;
use Cloudinary\Api\Upload\UploadApi;

//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $payload = checkAuth(getallheaders());
    if ($payload['role'] == "admin") {
        $pro_Id = $_POST['id'];
        $arr = [];
        if (isset($_POST['name'])) {
            $arr['name'] = $_POST['name'];
        }
        if (isset($_POST['price'])) {
            $arr['price'] = $_POST['price'];
        }
        if (isset($_POST['promotion'])) {
            $arr['promotion'] = $_POST['promotion'];
        }
        if (isset($_POST['description'])) {
            $arr['description'] = $_POST['description'];
        }
        if (isset($_POST['size'])) {
            $arr['size'] = $_POST['size'];
        }
        if (isset($_POST['amount'])) {
            $arr['amount'] = $_POST['amount'];
        }
        $imageVal = array();
        if (isset($_FILES['image'])) {
            $fileName  =  $_FILES['image']['name'];
            $tempPath  =  $_FILES['image']['tmp_name'];

            for ($i = 0; $i < count($fileName); $i++) {
                if (empty($fileName[$i])) {
                    $errorMSG = json_encode(array("message" => "please select image", "status" => false));
                    echo $errorMSG;
                } else {
                    Configuration::instance([
                        'cloud' => [
                            'cloud_name' => 'cosmeticv1',
                            'api_key' => '128838644673239',
                            'api_secret' => 'Yfr5A065pD24L06Ke6QztwOFw8Y'
                        ],
                        'url' => [
                            'secure' => true
                        ]
                    ]);
                    $data = (new UploadApi())->upload($tempPath[$i], [
                        'folder' => 'cosmetic/productsFake/',
                        'public_id' => $fileName[$i],
                        'overwrite' => true,
                        'resource_type' => 'image'
                    ]);
                    array_push($imageVal, $data['secure_url']);
                }
            }
        }
        $arr['image'] = json_encode($imageVal, JSON_OBJECT_AS_ARRAY);
        date_default_timezone_set('Asia/Ho_Chi_Minh');
        $updateAt = date("d-m-Y H:i:s");
        $arr['updateAt'] = $updateAt;
        $sql = $obj->update("products", $arr, "`products`.`id` = $pro_Id");
        if ($sql) {
            $result = $obj->getResult();
            http_response_code(200);
            echo json_encode(array("message" => "update product success !"));
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "failed"));
        }
    } else {
        http_response_code(401);
        echo json_encode([
            "status" => 'error',
            "message" => "You are not authorized"
        ]);
    }
} else {

    echo json_encode(array(
        "status" => "error",
        "message" => "access denied",
    ));
}
