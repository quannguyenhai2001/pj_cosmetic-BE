
<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: *");
include_once ("../database/database.php");


$obj = new Database();

// $response = array();
// $upload_dir = 'uploads/';
// $server_url = 'http://127.0.0.1:80';

// if($_FILES['avatar'])
// {
//     $avatar_name = $_FILES["avatar"]["name"];
//     $avatar_tmp_name = $_FILES["avatar"]["tmp_name"];
//     $error = $_FILES["avatar"]["error"];

//     if($error > 0){
//         $response = array(
//             "status" => "error",
//             "error" => true,
//             "message" => "Error uploading the file!"
//         );
//     }else 
//     {
//         $random_name = rand(1000,1000000)."-".$avatar_name;
//         $upload_name = $upload_dir.strtolower($random_name);
//         $upload_name = preg_replace('/\s+/', '-', $upload_name);
    
//         if(move_uploaded_file($avatar_tmp_name , $upload_dir)) {
// 			move_uploaded_file($avatar_tmp_name , $upload_dir);
//             $response = array(
//                 "status" => "success",
//                 "error" => false,
//                 "message" => "File uploaded successfully",
//                 "url" => $server_url."/".$upload_name,
// 				"file"=>$_FILES["avatar"]
//               );
//         }else
//         {
//             $response = array(
//                 "status" => "error",
//                 "error" => true,
//                 "message" => "Error uploading the file!"
//             );
//         }
//     }



    

// }else{
//     $response = array(
//         "status" => "error",
//         "error" => true,
//         "message" => "No file was sent!"
//     );
// }

// echo json_encode($response);





$data = json_decode(file_get_contents("php://input"),true); // collect input parameters and convert into readable format
	
 $fileName  =  $_FILES['sendimage']['name'];
$tempPath  =  $_FILES['sendimage']['tmp_name'];
$fileSize  =  $_FILES['sendimage']['size'];

print_r($_FILES);



if(empty($fileName))
{
	$errorMSG = json_encode(array("message" => "please select image", "status" => false));	
	echo $errorMSG;
}
else
{
    
$upload_path = '../upload/products/'; // set upload folder path 
	
	$fileExt = strtolower(pathinfo($fileName,PATHINFO_EXTENSION)); // get image extension
		
	// valid image extensions
	$valid_extensions = array('jpeg', 'jpg', 'png', 'gif'); 
					
	// allow valid image file formats
	if(in_array($fileExt, $valid_extensions))
	{				
		//check file not exist our upload folder path
		if(!file_exists($upload_path . $fileName))
		{
			// check file size '5MB'
			if($fileSize < 5000000){
				move_uploaded_file($tempPath, $upload_path . $fileName); // move file from system temporary path to our upload folder path 
			}
			else{		
				$errorMSG = json_encode(array("message" => "Sorry, your file is too large, please upload 5 MB size", "status" => false));	
				echo $errorMSG;
			}
		}
		else
		{		
			$errorMSG = json_encode(array("message" => "Sorry, file already exists check upload folder", "status" => false));	
			echo $errorMSG;
		}
	}
	else
	{		
		$errorMSG = json_encode(array("message" => "Sorry, only JPG, JPEG, PNG & GIF files are allowed", "status" => false));	
		echo $errorMSG;		
	}
}
		
if(!isset($errorMSG))
{

	$obj->insert("products",["image"=>$fileName]);
	echo json_encode(array("message" => "Image Uploaded Successfully", "status" =>  $_FILES['sendimage']));	
}

?>