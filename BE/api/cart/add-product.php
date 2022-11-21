
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
        $id = $data->id;
        //check amount of products in product table
        $amountPro = $obj->getResult($obj->select("products", "amount", "", "", "id = $id"));
        if ($amountPro > 0) {
            //check cart exist or not
            $isExistCart = $obj->select("cart", "id", "", "", "user_Id = $payload[id]");
            if ($isExistCart) {
                $cartId = intval($obj->getResult($isExistCart)[0]['id']);
                //get list product in table cart details
                $isGetListProduct = $obj->select("products", "`products`.`id`,`products`.`name`,`products`.`image`,`products`.`price`,`products`.`promotion`,`products`.`size`,`cart_details`.`quantity`", "`cart_details` JOIN `cart`", "`products`.`id` = `cart_details`.`pro_Id` and `cart_details`.`cart_Id` = `cart`.`id`", "cart.`user_Id` = $payload[id]", "", "");
                if ($isGetListProduct) {
                    $arr = $obj->getResult();
                    $isCheckId = true;
                    //increase quantity of product in cart details
                    foreach ($arr as $key => $value) {
                        if ($value["id"] == $id) {
                            $convertProId = intval($arr[$key]['id']);
                            $quantity = intval($arr[$key]['quantity']) + 1;
                            $sql = $obj->update("cart_details", [
                                "quantity" => $quantity
                            ], "cart_Id = $cartId and pro_Id = $convertProId");
                            if ($sql) {
                                echo "increase success";
                            } else {
                                echo json_encode(array("message" => "increase failed"));
                            }
                            $isCheckId = false;
                            break;
                        }
                    }
                    //add product to cart details
                    if ($isCheckId) {
                        $isAddToCartDetail = $obj->insert("cart_details", [
                            "pro_Id" => $id,
                            "cart_Id" => $cartId,
                            "quantity" => 1
                        ]);
                        if ($isAddToCartDetail) {
                            echo "add to cart details success";
                        } else {
                            echo json_encode(array("message" => "add to cart details failed"));
                        }
                    }
                } else {
                    //add new product to cart details
                    $isAddToCartDetail = $obj->insert("cart_details", [
                        "pro_Id" => $id,
                        "cart_Id" => $cartId,
                        "quantity" => 1
                    ]);
                    if ($isAddToCartDetail) {
                        echo "add to cart details success";
                    } else {
                        echo json_encode(array("message" => "add to cart details failed"));
                    }
                }
            } else {
                //add new cart and add product to cart details
                $isAddToCart = $obj->insert("cart", [
                    "user_Id" => $payload['id'],
                ]);
                if ($isAddToCart) {
                    $isGetCartId = $obj->select("cart", "id", "", "", "user_Id = $payload[id]", "", "");
                    if ($isGetCartId) {
                        $cartId = intval($obj->getResult()[0]['id']);
                        $isAddToCartDetail = $obj->insert("cart_details", [
                            "pro_Id" => $id,
                            "cart_Id" => $cartId,
                            "quantity" => 1
                        ]);
                        if ($isAddToCartDetail) {
                            http_response_code(200);
                            echo json_encode(array("message" => "create cart and add to cart details success"));
                        } else {
                            http_response_code(400);
                            echo json_encode(array("message" => "create cart and add to cart details failed"));
                        }
                    } else {
                        http_response_code(400);
                        echo json_encode(array("message" => "get cart id failed"));
                    }
                } else {
                    http_response_code(400);
                    echo json_encode(array("message" => "add to card failed"));
                }
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "product is out of stock"));
        }
    } else {
        http_response_code(404);
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

?>