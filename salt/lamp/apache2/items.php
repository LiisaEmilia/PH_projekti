<?php
$user = "postgres";
$password = "password";
$database = "demo";
$table = "items";

try {
  $db = new PDO("pgsql:host=localhost;dbname=$database", $user, $password);
  echo "<h2>TODO</h2><ol>";
  foreach($db->query("SELECT item FROM $table") as $row) {
    echo "<li>" . $row['item'] . "</li>";
  }
  echo "</ol>";
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
