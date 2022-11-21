<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

//import file
include_once "../database/database.php";
include_once "../middleware/check-auth.php";
//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $payload = checkAuth(getallheaders());
    if ($payload['role'] == "admin") {
        $data = json_decode(file_get_contents("php://input", true));
        $name = htmlspecialchars(strip_tags($data->name));
        $fatherCateId = htmlspecialchars(strip_tags($data->fatherCateId));
        $sql = $obj->insert("categories", [
            "name" => $name,
            "fatherCateId" => $fatherCateId
        ]);
        if ($sql) {
            http_response_code(200);
            echo json_encode([
                "status" => 'success',
                "message" => "Category created successfully"
            ]);
        } else {
            http_response_code(500);
            echo json_encode([
                "status" => 'error',
                "message" => "Category not created"
            ]);
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
