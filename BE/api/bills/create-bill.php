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
        $data = json_decode(file_get_contents("php://input", true));
        //get all product from cart
        $sql = $obj->select("products", "`products`.`id`,`products`.`name`,`products`.`image`,`products`.`price`,`products`.`promotion`,`products`.`size`,`cart_details`.`quantity`,`cart`.`id` as cartId", "`cart_details` JOIN `cart`", "`products`.`id` = `cart_details`.`pro_Id` and `cart_details`.`cart_Id` = `cart`.`id`", "cart.`user_Id` = $payload[id]", "", "");
        if ($sql) {
            $result = $obj->getResult();
            $convertCartId = intval($result[0]['cartId']);
            //delete all product in cart
            $deleteCart = $obj->delete("cart", "cart.`id` = $convertCartId");
            if ($deleteCart) {
                //get payment info
                $array_param = [
                    'receiverName' => $data->receiverName,
                    'phone' => $data->phone,
                    'deliveryDate' => date("d-m-Y"),
                    'notes' => $data->notes,
                    'status' => "Pending",
                    'total' => $data->total,
                    'deliveryAddress' => $data->deliveryAddress,
                    'paymentMethod' => $data->paymentMethod,
                    'user_Id' => $payload['id']
                ];
                $paymentInfo = $obj->insert('bills', $array_param);
                if ($paymentInfo) {
                    //get bill_Id
                    $bill_Id = $obj->select("bills", "id", "", "", "user_Id = $payload[id]", "id DESC", "", "", "", "");
                    if ($bill_Id) {
                        $bill_Id = $obj->getResult();
                        //add product info to bill-details
                        foreach ($result as $product) {
                            $array_param = [
                                'amount' => floatval($product['quantity']),
                                'pro_Id' => $product['id'],
                                'bill_Id' => intval($bill_Id[0]['id'])
                            ];
                            $addProInfo = $obj->insert('bill_details', $array_param);
                            if ($addProInfo) {
                                //convert pro_Id from product
                                $pro_Id = intval($product['id']);
                                // select amount from product to caculate new amount
                                $amount = $obj->select("products", "amount", "", "", "id = '$pro_Id'", "", "", "", "", "");
                                if ($amount) {
                                    $amount = $obj->getResult();
                                    $value = intval($amount[0]['amount']) - intval($product['quantity']);
                                    //update amount
                                    $updateAmount = $obj->update("products", ["amount" => $value], "id = '$pro_Id'");
                                    if ($updateAmount) {
                                        echo json_encode(array("message" => "payment success !"));
                                    } else {
                                        echo json_encode(array("message" => "payment failed !"));
                                    }
                                }
                            } else {
                                echo json_encode(array("message" => "add product failed"));
                            }
                        }
                    } else {
                        echo json_encode(array("message" => "get bill id failed"));
                    }
                } else {
                    echo json_encode(array("message" => "insert failed"));
                }
            } else {
                echo json_encode(array("message" => "delete failed"));
            }
        } else {
            echo json_encode(array("message" => "get product failed"));
        }
    } else {
        http_response_code(401);
        echo json_encode([
            "status" => 'error',
            "message" => "You are not authorized"
        ]);
    }
} else {
    echo json_encode([
        "status" => 'error',
        "message" => "Method not allowed"
    ]);
}
