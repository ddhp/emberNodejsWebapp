<?php
$name = $_POST['name'];
$company = $_POST['company'];
$userMessage = $_POST['message'];
$email = $_POST['email'];
$phone = $_POST['phone'];
if (($phone) == '') {
  $phone = "Not provided";
};
// $to = "chiayuanh@ocn.com.tw";
$to = "sevenknee@gmail.com";
$subject = "A message from customer";
// $message = "Hello! This is a simple email message.";
$message = '<html><body>';
$message .= '<p>This is a reminder to inform you that there is a inquery from official website("www.ocn.com.tw")</p>';
$message .= '<p>Here is the information from customer:</p>';
$message .= '<hr>';
$message .= '<p>Name: <strong>' . $name . '</strong></h4>';
$message .= '<p>Company: <strong>' . $company . '</strong></h4>';
$message .= '<p>Email: <strong>' . $email . '</strong></h4>';
$message .= '<p>Phone: <strong>' . $phone . '</strong></h4>';
$message .= '<p>Message: <strong>' . $userMessage . '</strong></h4>';
$message .= '<hr>';
$message .= '<p>Please reply him asap!</p>';
$message .= "</body></html>";

$from = "reminder@ocn.com.tw";
// $headers = "From: $from";
$headers = "From: " . strip_tags($from) . "\r\n";
// $headers .= "Reply-To: ". strip_tags($_POST['req-email']) . "\r\n";
// $headers .= "CC: susan@example.com\r\n";
$headers .= "MIME-Version: 1.0\r\n";
$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

mail($to,$subject,$message,$headers);
echo "Mail Sent.";
?>
