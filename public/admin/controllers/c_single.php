<?php
require_once('models/Catalog.php');
$id = $_GET['id'];
$catalog = new Catalog($db);

if($_GET['id_img']) {
  $id_img = $_GET['id_img'];
  $catalog->db->Delete('photos', 'id', $id_img);
}


$specifications = $catalog->getSpecifications($id);

$photos = $catalog->db->Select('photos', 'id_prod', $id, true);
$product = $catalog->getProduct($id);
$data = array(
  'product' => $product,
  'category' => $catalog->db->Select('categories', 'id', $product['id_cat']),
  'specifications' => $specifications,
  'photos' => $photos,
);
