<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

//import file
include_once "../database/database.php";
include_once "../middleware/check-auth.php";

include_once("../vendor/autoload.php");

use Cloudinary\Configuration\Configuration;
use Cloudinary\Api\Upload\UploadApi;
//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $payload = checkAuth(getallheaders());
    if ($payload && $payload['role'] == "user") {
        if (isset($_POST['password'])) {
            $isUser = $obj->select("users", "*", null, null, "id='$payload[id]'", null, null);
            if ($isUser) {
                $datas = $obj->getResult();
                // if (password_verify($_POST['oldPassword'], $datas[0]['password'])) {
                $newPassword = password_hash($_POST['password'], PASSWORD_DEFAULT);
                $sql = $obj->update("users", ['password' => $newPassword], "`users`.`id` = $payload[id]");
                if ($sql) {
                    echo json_encode([
                        "status" => "success",
                        "message" => "User updated successfully"
                    ]);
                } else {
                    echo json_encode([
                        "status" => "error",
                        "message" => "User not updated"
                    ]);
                }
                //     } else {
                //         echo json_encode(array(
                //             "status" => "error",
                //             "message" => "old password is wrong",
                //         ));
                //         return;
                //     }
            } else {
                echo json_encode(array(
                    "status" => "error",
                    "message" => "user not found",
                ));
            }
        } else {
            $arr = array();
            if (isset($_POST['displayName'])) {
                $arr['displayName'] = $_POST['displayName'];
            }
            if (isset($_POST['sex'])) {
                $arr['sex'] = $_POST['sex'];
            }
            if (isset($_POST['address'])) {
                $arr['address'] = $_POST['address'];
            }
            if (isset($_POST['age'])) {
                $arr['age'] = $_POST['age'];
            }
            if (isset($_FILES['avatar'])) {
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
                $data = (new UploadApi())->upload($_FILES['avatar']['tmp_name'], [
                    'folder' => 'cosmetic/avatar/',
                    'public_id' => $_FILES['avatar']['name'],
                    'overwrite' => true,
                    'resource_type' => 'image'
                ]);

                $arr['avatar'] = $data['secure_url'];
            }
            $sql = $obj->update("users", $arr, "`users`.`id` = $payload[id]");
            if ($sql) {
                echo json_encode([
                    "status" => "success",
                    "message" => "User updated successfully"
                ]);
            } else {
                echo json_encode([
                    "status" => "error",
                    "message" => "User not updated"
                ]);
            }
        }
    } else {
        echo json_encode(
            [
                "status" => "error",
                "message" => "You are not authorized"
            ]
        );
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied",
    ));
}
