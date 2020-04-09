<?php
class Catalog
{
  function __construct()
  {
    $this->db = SQL::Instance();
  }

  public function getSpecifications($id) {
    return $this->db->CompositeQuery("SELECT t1.id, t1.value, t2.name, t2.unit FROM `specifications` AS `t1` 
    INNER JOIN `properties` AS t2 ON t1.id_prop = t2.id WHERE t1.id_prod = $id");
  }

  public function getCategories()
  {
    $categories = [];
    foreach ($this->db->Select('categories') as $k => $v) {
      $v['props'] = $this->db->Select('properties', 'id_cat', $v['id'], true);
      $categories[] = $v;
    }
    return $categories;
  }
  // работа с категориями
  public function setCatImg($category, $img, $action)
  {
    $cat['name'] = $category['name'];
    $cat['title'] = $category['title'];

    // если есть картинка прогоняем через транслит
    if (!empty($img['tmp_name'])) $cat['img'] = $category['img'] = translit($img['name']);

    // получаем id
    $cat['id'] = $category['id'] ? $category['id'] : $this->db->Insert('categories', $category);

    // создаем папку и копируем изображение, если оно есть
    if (!empty($img['tmp_name'])) {
      $folder = '../db/images/category/' . $cat['id'] . '/';
      $path = $folder . $cat['img'];
      if (!file_exists($folder)) mkdir($folder, 0700, true);
      move_uploaded_file($img['tmp_name'], $path);
    }

    // обновляем и добавляем характеристики
    if (!empty($category['prop_name'])) {
      for ($i = 0; $i < count($category['prop_name']); $i++) {
        $props = [
          'id_cat' => $category['id'],
          'name' => $category['prop_name'][$i],
          'unit' => $category['prop_unit'][$i],
          'filter' => $category['prop_filter'][$i]
        ];
        if ($category['prop_id'][$i]) {
          $this->db->Update('properties', $props, 'id', $category['prop_id'][$i]);
        } else {
          // добавляем новую характеристику и присваиваем ее всем товарам категории
          $id_prop = $this->db->Insert('properties', $props);
          $id_cat = $cat['id'];
          $products = $this->db->Select('products', 'id_cat', $id_cat, true);
          foreach ($products as $product) {
            $id_prod = $product['id'];
            $spec = [
              'id_prod' => $id_prod,
              'id_prop' => $id_prop,
              'value' => ''
            ];
            $this->db->Insert('specifications', $spec);
          }
        }
      }
    }
    if ($action == 'update') {
      $this->db->Update('categories', $cat, 'id', $cat['id']);
    }
    // elseif ($action == 'add') {
    //   $category['id'] = $this->db->Insert('categories', $category);
    //   $folder = '../db/images/category/' . $category['id'] . '/';
    //   $path = $folder . $category['img'];
    //   if (!file_exists($folder)) mkdir($folder, 0700, true);
    //   move_uploaded_file($img['tmp_name'], $path);
    //   $this->db->Update('categories', $category, 'id', $category['id']);
    // }
  }
  public function getShopFeedbacks()
  {
    return $this->db->Select('feedbacks', 'id_prod', '-1', true);
  }
  public function saveFeedback($feedback)
  {
    print_r($feedback);
    $this->db->Insert('feedbacks', $feedback);
  }
  public function getAll()
  {
    $result = $this->db->CompositeQuery('SELECT 
    products.id AS id, 
    products.title AS title,   
    products.detail AS detail,   
    products.features AS features, 
    products.price_new AS price_new, 
    products.price_old AS price_old, 
    categories.name AS category,
    categories.img AS cat_img FROM products
    INNER JOIN categories ON products.id_cat = categories.id');
    $products = [];
    foreach ($result as $k => $v) {
      $id = $v['id'];
      $product = [];
      $product['desc'] = $v['detail'];
      $product['photos'] = $this->db->Select('photos', 'id_prod', $id, true);
      $product['feedbacks'] = $this->db->Select('feedbacks', 'id_prod', $id, true);
      $product['spec'] = $this->db->CompositeQuery("SELECT t1.value AS `value`, t2.name AS prop, t2.filter AS `filter` 
      FROM specifications AS t1 INNER JOIN properties AS t2 WHERE t1.id_prop = t2.id AND t1.id_prod = $id");
      // Select('specifications', 'id_prod', $v['id'], true)
      
      foreach ($v as $key => $value) {
        $product[$key] = $value;
      }
      $products[] = $product;
    }
    return $products;
  }
  public function getProduct($id)
  {
    return $this->db->Select('products', 'id', $id);
  }
  public function addProduct($post, $files)
  {
    $product = $this->prepareProduct($post, $files);
    // return $this->db->Insert('products', $product);
  }
  public function updateProduct($post, $files)
  {
    $product = $this->prepareProduct($post, $files);
    return $this->db->Update('products', $product, 'id', $product['id']);
  }
  public function removeProduct($id)
  {
    $this->db->Delete('products', 'id', $id);
  }
  public function prepareProduct($post, $files)
  {
    extract($post);

    $product = [
      'title' => $title,
      'detail' => $desc,
      'features' => $features,
      'price_new' => $price_new,
      'price_old' => $price_old,
    ];

    if ($id) {
      $this->db->Update('products', $product, 'id', $id);
    } else {
      $product['id_cat'] = $id_cat;
      $id = $this->db->Insert('products', $product);
    }

    if (!empty($spec_prop))
      for ($k = 0; $k < count($spec_prop); $k++) {
        if ($id_spec[$k]) {
          $this->db->Update('specifications', [
            'value' => $spec_val[$k]
          ], 'id', $id_spec[$k]);
        } else {
          $this->db->Insert('specifications', [
            'id_prod' => $id,
            'id_prop' => $spec_prop[$k],
            'value' => $spec_val[$k]
          ]);
        }
      }

    if (($files['photo']['name'][0])) {
      $files = $files['photo'];
      for ($i = 0; $i < count($files['name']); $i++) {
        $type = $files['type'][$i];
        $photo['id_prod'] = $id;
        $photo['alt'] = $files['name'][$i];
        $photo['src'] = substr(md5_file($files['tmp_name'][$i]), -10) . '_' . translit($files['name'][$i]);
        $this->db->Insert('photos', $photo);
        $path_big = "../db/images/products/big/$id/";
        $path_small = "../db/images/products/small/$id/";
        if (!file_exists("../db/images/products/small/$id/")) {
          mkdir($path_big, 0700, true);
          mkdir($path_small, 0700, true);
        }
        $mas = ['image/jpeg', 'image/png', 'image/gif'];
        if (in_array($files['type'][$i], $mas)) {
          if (move_uploaded_file($files['tmp_name'][$i], $path_big . $photo['src'])) {
            imageresize($type, $path_small . $photo['src'], $path_big . $photo['src'], 400, 250, 75);
          } else echo 'файлы не найдены';
        } else echo 'Можно загрузить только изображения в формате .jpg, .png или .gif';
      }
    }
    return $product;
  }
}
