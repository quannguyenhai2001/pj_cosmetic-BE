<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");

//import file
include_once "../database/database.php";
include_once "../middleware/check-auth.php";

//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "GET") {
    $payload = checkAuth(getallheaders());
    if ($payload && $payload['role'] == "user") {
        $data = json_decode(file_get_contents("php://input", true));
        $sql = $obj->select("products", "`products`.`id`,`products`.`name`,`products`.`image`,`products`.`price`,`products`.`promotion`,`products`.`size`,`cart_details`.`quantity`", "`cart_details` JOIN `cart`", "`products`.`id` = `cart_details`.`pro_Id` and `cart_details`.`cart_Id` = `cart`.`id`", "cart.`user_Id` = $payload[id]", "", "");
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
        http_response_code(401);
        echo json_encode(array(
            "status" => "error",
            "message" => "unauthorized"
        ));
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied"
    ));
}
