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
    $pro_Id =  $_GET['id'];
    //get all child categories
    $sql = $obj->select("comments", "comments.`id`, comments.`content`, comments.`cmtDate`, comments.`updateAt`, comments.`user_Id`,`avatar`, displayName", "products JOIN users", "comments.`pro_Id`=`products`.`id` and comments.`user_Id` = users.`id`", "products.`id`= '$pro_Id'", "", "");
    if ($sql) {
        $result = $obj->getResult();
        http_response_code(200);
        echo json_encode(array(
            "status" => "success",
            "data" => $result,
        ));
    } else {
        http_response_code(400);
        echo json_encode(array(
            "status" => "failed",
            "message" => "failed"

        ));
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied",
    ));
}
