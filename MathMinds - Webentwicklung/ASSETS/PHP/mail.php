<?php 
  
   $name =$_POST['Name'];
   $to=$_POST['Email'];
   $subject = 'Simply Math';
   $messages= 'Sehr geehrte/-r Frau/Herr '.$_POST['Name'].',
   
   hiermit bestätigen wir ihre Nachricht:

         [ '.$_POST['Messages'].' ]

   Wir werden sie möglich schnell kontaktieren

   Mit freundlichen Grüßen
   Team Simply Math
   ';
  $headers = 'From: gmn09000@gmail.com'       . "\r\n" .
                 'Reply-To: gmn09000@gmail.com' . "\r\n" .
                 'X-Mailer: PHP/' . phpversion();
   mail($to,$subject,$messages, $headers);
   header('Location: ../../kontakt.html');
?>