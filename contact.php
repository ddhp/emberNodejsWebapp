<?php
$name = $_POST[name];
$company = $_POST[company];
$message = $_POST[message];
$email = $_POST[email];
$phone = $_POST[phone];
if (($phone) == '') {
  $phone = "Not provided";
};
// $to = "chiayuanh@ocn.com.tw";
$to = "sevenknee@gmail.com";
$subject = "A message from customer";
// $message = "Hello! This is a simple email message.";
$message = '<html><body>';
$message .= 'Here is the message from customer:';
$message .= '<h4>Name</h4>';
$message .= '<p><strong>' . $name . '</strong></h4>';
$message .= '<h4>Company</h4>';
$message .= '<p><strong>' . $company . '</strong></h4>';
$message .= '<h4>Email</h4>';
$message .= '<p><strong>' . $email . '</strong></h4>';
$message .= '<h4>Phone</h4>';
$message .= '<p><strong>' . $phone . '</strong></h4>';
$message .= '<h4>Message</h4>';
$message .= '<p><strong>' . $message . '</strong></h4>';
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
