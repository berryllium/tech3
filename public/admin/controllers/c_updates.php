<?php

// находим товары, у которых не отображаются характеристики, прописанные в их категории

$props = $db->Select('properties');
foreach($props as $prop) {
  $id_prop = $prop['id'];
  $id_cat = $prop['id_cat'];
  $products = $db->Select('products', 'id_cat', $id_cat, true);
  foreach ($products as $product) {
    $id_prod = $product['id'];

    if(!$db->CompositeQuery("SELECT * FROM specifications WHERE id_prod = $id_prod AND id_prop = $id_prop")) {
      echo 'нет такой характеристики <br>';
      $spec = [
        'id_prod' => $id_prod,
        'id_prop' => $id_prop,
        'value' => ''
      ];
      $db->Insert('specifications', $spec);
  }
  }
}