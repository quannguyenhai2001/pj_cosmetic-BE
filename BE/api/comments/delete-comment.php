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
    if ($payload && $payload['role'] == "admin") {
        //get data from client
        $data = json_decode(file_get_contents("php://input", true));
        $sql = $obj->delete("comments", "`comments`.`id` = $data->id");
        if ($sql) {
            echo "delete success !";
        } else {
            echo json_encode(array("message" => "failed"));
        }
    } else if ($payload && $payload['role'] == "user") {
        $data = json_decode(file_get_contents("php://input"));
        $sql = $obj->delete("comments", "`comments`.`id` = $data->id AND `comments`.`user_Id` = $payload[id]");
        if ($sql) {
            echo "delete success !";
        } else {
            echo json_encode(array("message" => "failed"));
        }
    } else {
        http_response_code(403);
        echo json_encode(array("message" => "you are not authorized"));
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied",
    ));
}
