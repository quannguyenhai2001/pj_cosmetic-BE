<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");

//import file
include_once "../database/database.php";
include_once "../middleware/check-auth.php";

//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "PUT") {
    $payload = checkAuth(getallheaders());
    if ($payload['role'] == 'admin') {
        $data = json_decode(file_get_contents("php://input", true));
        //convert to string
        $bill_Id = $data->bill_Id;
        $status = "Success";
        $sql = $obj->update("bills", [
            "status" => $status,
        ], "bills.`id` = $bill_Id");
        if ($sql) {
            http_response_code(200);
            echo json_encode([
                "status" => 'success',
                "message" => "Bill updated successfully"
            ]);
        } else {
            http_response_code(500);
            echo json_encode([
                "status" => 'error',
                "message" => "Bill not updated"
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
