<?php
//add headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");

//import file
include_once("../database/database.php");

//initialize database
$obj = new Database();

//check method request
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $data = json_decode(file_get_contents("php://input", true));

    //convert to string
    $displayName = htmlspecialchars(strip_tags($data->displayName));
    $userName = htmlspecialchars(strip_tags($data->userName));
    $email = htmlspecialchars(strip_tags($data->email));
    $password = htmlentities(strip_tags($data->password));
    $phoneNumber = htmlspecialchars(strip_tags($data->phoneNumber));
    $address = htmlspecialchars(strip_tags($data->address));
    $sex = htmlspecialchars(strip_tags($data->sex));
    $age = htmlspecialchars(strip_tags($data->age));
    // if(var_dump($sex) !=Number){

    // }
    $role = "user";
    //hash password
    $newPassword = password_hash($password, PASSWORD_DEFAULT);
    date_default_timezone_set('Asia/Ho_Chi_Minh');
    //check user by email
    $isEmail = $obj->select("users", "email", null, null, "email='$email'", null, null);
    $emailInDB = $obj->getResult();

    if ($isEmail) {
        // check email query result

        http_response_code(400);
        echo json_encode([
            "status" => 0,
            "field" => "email",
            "message" => "Email already exist",
        ]);
    } else {
        $array_param = [
            'displayName' => $displayName,
            'userName' => $userName,
            'email' => $email,
            'password' => $newPassword,
            'phoneNumber' => $phoneNumber,
            'address' => $address,
            'sex' => $sex,
            'age' => $age,
            'role' => $role,
            'createAt' => date("d-m-Y H:i:s"),
        ];

        //add new user to database
        $obj->insert('users', $array_param);
        $result = $obj->getResult();

        //check result (result return true and false)
        if ($result[0] == 1) {
            http_response_code(200);
            echo json_encode([
                "status" => "success",
                "message" => "Create user successfully",
            ]);
        } else {
            http_response_code(400);
            echo json_encode([
                "status" => "error",
                "message" => $result[0],
            ]);
        }
    }
} else {
    echo json_encode(array(
        "status" => "error",
        "message" => "access denied"
    ));
}
