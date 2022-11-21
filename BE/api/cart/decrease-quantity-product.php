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
        $id = $data->id;
        //get list product in table cart
        $isGetListProduct = $obj->select("products", "`products`.`id`,`products`.`name`,`products`.`image`,`products`.`price`,`products`.`promotion`,`products`.`size`,`cart_details`.`quantity`,`cart`.`id` as cartId", "`cart_details` JOIN `cart`", "`products`.`id` = `cart_details`.`pro_Id` and `cart_details`.`cart_Id` = `cart`.`id`", "cart.`user_Id` = $payload[id]", "", "");
        if ($isGetListProduct) {
            $arr = $obj->getResult();
            foreach ($arr as $product => $value) {
                if ($value["id"] == $id && $value['quantity'] > 1) {
                    $convertCartId = intval($arr[$product]['cartId']);
                    $arr[$product]['quantity']--;
                    $sql = $obj->update("cart_details", [
                        "quantity" => $arr[$product]['quantity']
                    ], "cart_Id = $convertCartId and pro_Id = $id");
                    if ($sql) {
                        http_response_code(200);
                        echo json_encode(array(
                            "message" => "decrease success"
                        ));
                    } else {
                        http_response_code(500);
                        echo json_encode(array("message" => "decrease failed"));
                        break;
                    }
                }
            }
        } else {
            echo json_encode(array("message" => "cart is empty"));
        }
    } else {
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
