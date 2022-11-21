<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

//import file
include_once("../database/database.php");
include_once("../vendor/autoload.php");

//Namespace
use \Firebase\JWT\JWT;
use Firebase\JWT\Key;

$obj = new Database();


if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $data = json_decode(file_get_contents("php://input", true));

    //convert to string
    $email = htmlspecialchars(strip_tags($data->email));
    $password =  htmlentities(strip_tags($data->password));

    //check user exist by email?
    $isUser = $obj->select("users", "*", null, null, "email='$email'", null, null);
    $datas = $obj->getResult();
    if ($isUser) {
        if (password_verify($password, $datas[0]['password'])) {
            $payload = array(
                "iss" => "localhost",
                "aud" => "localhost",
                "exp" => time() + 60 * 60 * 244444,
                "data" => array(
                    "id" => $datas[0]['id'],
                    "role" => $datas[0]['role']
                )
            );

            $jwt = JWT::encode($payload, $_ENV['PRIVATE_KEY'], 'HS256');
            http_response_code(200);
            echo json_encode([
                "status" => 1,
                "message" => "Login successfully",
                "user" => $datas[0],
                "token" => $jwt,
            ]);
        } else {
            http_response_code(400);
            echo json_encode([
                "status" => 0,
                "field" => "password",
                "message" => "Password is incorrect",
            ]);
        }
    } else {
        http_response_code(400);
        echo json_encode([
            "status" => 0,
            "field" => "email",
            "message" => "Email is incorrect",
        ]);
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied"
    ));
}
