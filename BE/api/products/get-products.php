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
    $price = [0, 1000];
    $promotion = -1;
    $manu_Id = "IS NOT NULL";
    // pagination
    $total = 0;
    $no_of_records_per_page = 0;
    $offset = 0;
    if (isset($_GET['page'])) {
        $page = $_GET['page'];
    } else {
        $page = 1;
    }
    if (isset($_GET['limit'])) {
        $no_of_records_per_page = $_GET['limit'];
        $offset = ($page - 1) * $no_of_records_per_page;
    } else {
        $result = $obj->getResult($obj->select("products", "COUNT(*)", "", "", "", "", ""));
        $no_of_records_per_page = $result[0]['COUNT(*)'];
    }
    
    // search product by product name or manufacturer name
    if (isset($_GET['value'])) {
        $value = $_GET['value'];
        $sql = $obj->select("products", "products.`id`,`products`.`name` as productName,`products`.`image`,`products`.`price`,`products`.`promotion`,`manufacturers`.`name` as manufacturerName, `manufacturers`.`address` as manufacturerAddress", "categories JOIN manufacturers", "products.`cate_Id`=`categories`.`id` and  manufacturers.`id`=`products`.`manu_Id`", "(products.`name` LIKE '%{$value}%') OR (manufacturers.`name` LIKE '%{$value}%')", "", "$offset, $no_of_records_per_page");
        if ($sql) {
            $result = $obj->getResult();

            foreach ($result as $key => $product) {
                //select rating
                $sql1 = "SELECT ROUND(AVG(rating), 2) average, COUNT(user_Id) userNumber
                FROM star_rating
                WHERE pro_Id = '$product[id]'
                GROUP BY pro_Id";
                $rating = [];
                if ($obj->getConnection()->query($sql1)) {
                    $resultRating = $obj->getConnection()->query($sql1)->fetchAll(PDO::FETCH_ASSOC);
                    if ($resultRating) {
                        http_response_code(200);
                        array_push($rating, $resultRating[0]);
                        //add rating
                        $result[$key]['rating'] = $rating[0];
                    } else {
                        http_response_code(200);
                        array_push($rating, array("average" => 0, "userNumber" => 0));
                        $result[$key]['rating'] = $rating[0];
                    }
                } else {
                    http_response_code(400);
                    echo json_encode(array("message" => "failed"));
                    break;
                }
            }

            $total = count($obj->getResult($obj->select("products", "products.`id`,`products`.`name` as productName,`products`.`image`,`products`.`price`,`products`.`promotion`,`manufacturers`.`name` as manufacturerName,`manufacturers`.`address` as manufacturerAddress", "categories JOIN manufacturers", "products.`cate_Id`=`categories`.`id` and  manufacturers.`id`=`products`.`manu_Id`", "(products.`name` LIKE '%{$value}%') OR (manufacturers.`name` LIKE '%{$value}%')", "", "")));
            $pageTotal = ceil($total / $no_of_records_per_page);
            http_response_code(200);
            echo json_encode(array(
                "status" => "success",
                "data" => $result,
                "total" => $total,
                "pageTotal" => $pageTotal
            ));
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "failed"));
        }
    } else {
        //filter product by category, price, promotion, manufacturer
        if (isset($_GET['cate_Id'])) {
            $cate_Id = $_GET['cate_Id'];
            if (isset($_GET['price'])) {
                $price = $_GET['price'];
            }
            if (isset($_GET['promotion'])) {
                $promotion = 0;
            }
            if (isset($_GET['manu_Id'])) {
                $manu_Id = " = " . $_GET['manu_Id'];
            }
            $sql = $obj->selectByFilter("manufacturers", "products.`id`,`products`.`name` as productName, price, promotion, amount, image,`manufacturers`.`name` as manufacturerName, `manufacturers`.`address` as manufacturerAddress", " products JOIN categories", " manufacturers.`id`=`products`.`manu_Id` and categories.`id`=`products`.`cate_Id`", "$offset, $no_of_records_per_page", $cate_Id, $price, $promotion, $manu_Id);
            if ($sql) {
                $result = $obj->getResult();

                foreach ($result as $key => $product) {
                    //select rating
                    $sql1 = "SELECT ROUND(AVG(rating), 2) average, COUNT(user_Id) userNumber
                    FROM star_rating
                    WHERE pro_Id = '$product[id]'
                    GROUP BY pro_Id";
                    $rating = [];
                    if ($obj->getConnection()->query($sql1)) {
                        $resultRating = $obj->getConnection()->query($sql1)->fetchAll(PDO::FETCH_ASSOC);
                        if ($resultRating) {
                            http_response_code(200);
                            array_push($rating, $resultRating[0]);
                            //add rating
                            $result[$key]['rating'] = $rating[0];
                        } else {
                            http_response_code(200);
                            array_push($rating, array("average" => 0, "userNumber" => 0));
                            $result[$key]['rating'] = $rating[0];
                        }
                    } else {
                        http_response_code(400);
                        echo json_encode(array("message" => "failed"));
                        break;
                    }
                }

                // get all products number
                $total = count($obj->getResult($obj->selectByFilter("manufacturers", "products.`id`,`products`.`name` as productName, price, promotion, amount, image,`manufacturers`.`name` as manufacturerName, `manufacturers`.`address` as manufacturerAddress", " products JOIN categories", " manufacturers.`id`=`products`.`manu_Id` and categories.`id`=`products`.`cate_Id`", "", $cate_Id, $price, $promotion, $manu_Id)));
                $pageTotal = ceil($total / $no_of_records_per_page);
                http_response_code(200);
                echo json_encode(array(
                    "status" => "success",
                    "data" => $result,
                    "total" => $total,
                    "pageTotal" => $pageTotal
                ));
            } else {
                http_response_code(400);
                echo json_encode(array("message" => "failed"));
            }
        } else {
            $sql = $obj->select("manufacturers", "products.`id`,`products`.`name` as productName, price, promotion, amount, image,`manufacturers`.`name` as manufacturerName,`manufacturers`.`address` as manufacturerAddress", " products JOIN categories", " manufacturers.`id`=`products`.`manu_Id` and categories.`id`=`products`.`cate_Id`", "", "products.`id`", "$offset, $no_of_records_per_page");
            if ($sql) {
                $result = $obj->getResult();

                foreach ($result as $key => $product) {
                    //select rating
                    $sql1 = "SELECT ROUND(AVG(rating), 2) average, COUNT(user_Id) userNumber
                    FROM star_rating
                    WHERE pro_Id = '$product[id]'
                    GROUP BY pro_Id";
                    $rating = [];
                    if ($obj->getConnection()->query($sql1)) {
                        $resultRating = $obj->getConnection()->query($sql1)->fetchAll(PDO::FETCH_ASSOC);
                        if ($resultRating) {
                            http_response_code(200);
                            array_push($rating, $resultRating[0]);
                            //add rating
                            $result[$key]['rating'] = $rating[0];
                        } else {
                            http_response_code(200);
                            array_push($rating, array("average" => 0, "userNumber" => 0));
                            $result[$key]['rating'] = $rating[0];
                        }
                    } else {
                        http_response_code(400);
                        echo json_encode(array("message" => "failed"));
                        break;
                    }
                }
                $total = count($obj->getResult($obj->select("manufacturers", "products.`id`,`products`.`name` as productName, price, promotion, amount, image,`manufacturers`.`name` as manufacturerName,`manufacturers`.`address` as manufacturerAddress", " products JOIN categories", " manufacturers.`id`=`products`.`manu_Id` and categories.`id`=`products`.`cate_Id`", "", "", "")));
                $pageTotal = ceil($total / $no_of_records_per_page);
                http_response_code(200);
                echo json_encode(array(
                    "status" => "success",
                    "data" => $result,
                    "total" => $total,
                    "pageTotal" => $pageTotal
                ));
            } else {
                http_response_code(400);
                echo json_encode(array("message" => "failed"));
            }
        }
    }
} else {

    echo json_encode(array(
        "status" => "error",
        "message" => "access denied",
    ));
}
