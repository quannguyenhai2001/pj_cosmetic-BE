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
        $sql = $obj->select("bills", "`bill_details`.`id`,`products`.`id` as pro_Id, `products`.`name`, `bill_details`.`amount`, `products`.`price`, `products`.`promotion`, `bills`.`status`, `products`.`size`,`products`.`image`, `manufacturers`.`name` as ManufacturerName", "`bill_details` JOIN `products` JOIN `manufacturers`", "`bills`.`id` = `bill_details`.`bill_Id` AND `bill_details`.`pro_Id` = `products`.`id` AND `products`.`manu_Id` = `manufacturers`.`id`", "`bills`.`user_Id` = '$payload[id]'", "", "");
        if ($sql) {
            $result = $obj->getResult();
            //return rated result from rating table
            $isRated = array();
            $isGetRating = $obj->select("star_rating", "*", "", "", "`user_Id` = $payload[id]", "");
            if ($isGetRating) {
                $ratingResult = $obj->getResult();
                foreach ($result as $product => $value) {
                    foreach ($ratingResult as $productRating => $valueRating) {
                        if ($value['id'] == $valueRating['bill_details_Id'] && $value['pro_Id'] == $valueRating['pro_Id']) {
                            $result[$product]['rated'] = true;
                            goto next;
                        } else {
                            $result[$product]['rated'] = false;
                        }
                    }
                    next:
                    continue;
                }
                http_response_code(200);
                echo json_encode(array(
                    "status" => "success",
                    "data" => $result,
                ));
            } else {
                foreach ($result as $product => $value) {
                    $result[$product]['rated'] = false;
                }
                echo json_encode(array(
                    "status" => "success",
                    "data" => $result,
                ));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "failed"));
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
