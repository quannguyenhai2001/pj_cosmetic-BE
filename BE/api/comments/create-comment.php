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
        date_default_timezone_set('Asia/Ho_Chi_Minh');
        $data = json_decode(file_get_contents("php://input", true));
        //convert to string
        $comment = htmlspecialchars(strip_tags($data->comment));
        $pro_Id = $data->id;
        $sql = $obj->insert("comments", [
            "content" => $comment,
            "cmtDate" => date("d-m-Y H:i:s"),
            "user_Id" =>  $payload['id'],
            "pro_Id" => $pro_Id,
        ]);
        if ($sql) {
            http_response_code(200);
            echo json_encode([
                "status" => 'success',
                "message" => "Comment created successfully"
            ]);
        } else {
            http_response_code(500);
            echo json_encode([
                "status" => 'error',
                "message" => "Comment not created"
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
