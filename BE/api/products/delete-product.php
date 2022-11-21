<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: DELETE");

//import file
include_once "../database/database.php";
include_once "../middleware/check-auth.php";
//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "DELETE") {
    $payload = checkAuth(getallheaders());
    if ($payload['role'] == "admin") {
        //get data from client
        $data = json_decode(file_get_contents("php://input", true));
        //convert to string
        $pro_Id = $data->pro_Id;
        $sql = $obj->delete("products", "`products`.`id` = $pro_Id");
        if ($sql) {
            http_response_code(200);
            echo json_encode(array("message" => "delete product success !"));
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "delete product failed"));
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
