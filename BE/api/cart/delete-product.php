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
    if ($payload && $payload['role'] == "user") {
        $data = json_decode(file_get_contents("php://input", true));
        //convert to string
        $id = $data->id;
        //get list product in cart
        $isGetListProduct = $obj->select("products", "`products`.`id`,`products`.`name`,`products`.`image`,`products`.`price`,`products`.`promotion`,`products`.`size`,`cart_details`.`quantity`,`cart`.`id` as cartId", "`cart_details` JOIN `cart`", "`products`.`id` = `cart_details`.`pro_Id` and `cart_details`.`cart_Id` = `cart`.`id`", "cart.`user_Id` = $payload[id]", "", "");
        if ($isGetListProduct) {
            $arr = $obj->getResult();
            foreach ($arr as $product => $val) {
                if ($val["id"] == $id) {
                    $convertCartId = intval($arr[$product]['cartId']);
                    $sql = $obj->delete("cart_details", "cart_Id = $convertCartId and pro_Id = $id");
                    if ($sql) {
                        http_response_code(200);
                        echo json_encode(array("message" => "delete success"));
                        break;
                    } else {
                        http_response_code(400);
                        echo json_encode(array("message" => "delete failed"));
                        break;
                    }
                }
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "cart is empty"));
        }
    } else {
        http_response_code(400);
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
