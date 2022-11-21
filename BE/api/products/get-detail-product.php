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
    $id =  $_GET['id'];
    $sql = $obj->select("products", "products.`id`,`products`.`name` as productName,`products`.`image`,`products`.`price`,`products`.`promotion`,`products`.`description`,`products`.`size`,`manufacturers`.`name` as manufacturerName,`manufacturers`.`address` as manufacturerAddress", "manufacturers", "manufacturers.`id`=`products`.`manu_Id`", "products.`id` = '$id'", "", "");
    if ($sql) {
        $result = $obj->getResult();
        http_response_code(200);
        //select rating
        $sql1 = "SELECT ROUND(AVG(rating), 2) average, COUNT(user_Id) userNumber
        FROM star_rating
        WHERE pro_Id = '$id'
        GROUP BY pro_Id";
        $rating = [];
        if ($obj->getConnection()->query($sql1)) {
            $resultRating = $obj->getConnection()->query($sql1)->fetchAll(PDO::FETCH_ASSOC);
            if ($resultRating) {
                http_response_code(200);
                array_push($rating, $resultRating[0]);
                //add rating
                $result[0]['rating'] = $rating[0];
                echo json_encode(array(
                    "status" => "success",
                    "data" => $result[0],
                ));
            } else {
                http_response_code(200);
                array_push($rating, array("average" => 0, "userNumber" => 0));
                $result[0]['rating'] = $rating[0];
                echo json_encode(array(
                    "status" => "failed",
                    "data" => $result[0],
                ));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "failed"));
        }
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
