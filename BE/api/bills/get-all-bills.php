<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");

//import file
include_once "../database/database.php";

//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "GET") {
    $sql = $obj->select("bills", "*", "", "", "", "", "");
    if ($sql) {
        $result = $obj->getResult();
        http_response_code(200);
        echo json_encode(array(
            "status" => "success",
            "data" => $result,
        ));
    } else {
        http_response_code(400);
        echo json_encode(array("message" => "failed"));
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied",
    ));
}
