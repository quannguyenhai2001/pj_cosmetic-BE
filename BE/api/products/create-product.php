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
        $name = $_POST['name'];
        $price = $_POST['price'];
        $promotion = $_POST['promotion'];
        $amount = $_POST['amount'];
        $description = $_POST['description'];
        $size = $_POST['size'];
        $imageVal = array();

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
                    'folder' => 'cosmetic/products/',
                    'public_id' => $fileName[$i],
                    'overwrite' => true,
                    'resource_type' => 'image'
                ]);
                array_push($imageVal, $data['secure_url']);
            }
        }
        $image = json_encode($imageVal);
        date_default_timezone_set('Asia/Ho_Chi_Minh');
        $createAt = date("d-m-Y H:i:s");
        $manu_Id = $_POST['manu_Id'];
        $cate_Id = $_POST['cate_Id'];
        $sql = $obj->insert("products", [
            "id" => "",
            "name" => $name,
            "price" => $price,
            "promotion" => $promotion,
            "description" => $description,
            "size" => $size,
            "amount" => $amount,
            "image" => $image,
            "createAt" => $createAt,
            "manu_Id" => $manu_Id,
            "cate_Id" => $cate_Id
        ]);
        if ($sql) {
            http_response_code(200);
            echo json_encode(array("message" => "add product success"));
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "add product failed"));
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
