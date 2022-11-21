
<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: *");


print_r($_POST);
print_r($_SERVER['REQUEST_METHOD']);
  print_r(json_decode(file_get_contents("php://input", true)));
?>