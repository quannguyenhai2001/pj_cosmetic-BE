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
    //get all comments
    $sql = $obj->select("comments", "`comments`.*,`users`.`displayName`,`users`.`avatar`,`users`.`createAt` as UserCreatedAt,`users`.`updateAt` as UserUpdateAt", "`users`", "`comments`.`user_Id` = `users`.`id`", "", "", "");
    if ($sql) {
        $result = $obj->getResult();
        http_response_code(200);
        echo json_encode(array(
            "status" => "success",
            "data" => $result,
        ));
    } else {
        http_response_code(404);
        echo json_encode(array("message" => "failed"));
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied",
    ));
}
