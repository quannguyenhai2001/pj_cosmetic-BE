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
    if ($payload && $payload['role'] == "user") {
        $data = json_decode(file_get_contents("php://input", true));
        $pro_Id = $data->pro_Id;
        $rating = $data->rating;
        $bill_details_Id = $data->bill_details_Id;
        $sql = $obj->insert("star_rating", [
            "pro_Id" => $pro_Id,
            "user_Id" => $payload['id'],
            "rating" => $rating,
            "bill_details_Id" => $bill_details_Id,
        ]);
        if ($sql) {
            http_response_code(200);
            echo json_encode(array("message" => "success !"));
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
