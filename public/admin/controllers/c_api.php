<?php
require_once('models/Catalog.php');
$catalog = new Catalog;

if ($_GET['act'] == 'order') {
  require_once('models/Order.php');
  $order = new Order;
  $order->save($_POST);
  echo 'Заказ оформлен';
  exit;
}

if ($_GET['act'] == 'feedback') {
  $catalog->saveFeedback($_POST['feedback']);
  echo 'Отзыв записан';
  exit;
}

if ($_GET['act'] == 'mail') {
  $contacts = $catalog->db->Select('contacts', 'id', '1');
  $to = $contacts['email'];
  $message = $_POST['message'];
  if (mail($to, 'Заказ из магазина', $message)) echo 'Письмо отправлено';
  else echo 'Письмо не отправлено';
  exit;
}

$products = $catalog->getAll();
$categories = $catalog->getCategories();
$feedbacks = $catalog->getShopFeedbacks();
$contacts = $catalog->db->Select('contacts', 'id', '1');


$data = ['products' => $products, 'categories' => $categories, 'feedbacks' => $feedbacks, 'contacts' => $contacts];

echo json_encode($data, JSON_UNESCAPED_UNICODE);
