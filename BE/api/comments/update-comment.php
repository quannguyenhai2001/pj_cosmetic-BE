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
    if ($payload && $payload['role'] == "user") {
        $data = json_decode(file_get_contents("php://input", true));
        //convert to string
        $value = htmlspecialchars(strip_tags($data->value));
        $cmt_Id = $data->id;
        date_default_timezone_set('Asia/Ho_Chi_Minh');
        $updateAt = date("d-m-Y H:i:s");
        $sql = $obj->update("comments", [
            "content" => $value,
            "updateAt" => $updateAt,
        ], "comments.`id` = $cmt_Id and comments.`user_Id` = $payload[id]");
        if ($sql) {
            http_response_code(200);
            echo json_encode([
                "status" => 'success',
                "message" => "Comment updated successfully"
            ]);
        } else {
            http_response_code(500);
            echo json_encode([
                "status" => 'error',
                "message" => "Comment not updated"
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
