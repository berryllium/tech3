<?php
class Feedback
{
  function __construct()
  {
    $this->db = SQL::Instance();
  }

  public function getAll()
  {
    $feedbacks = $this->db->Select('feedbacks');
    $full = [];
    foreach ($feedbacks as $k => $v) {
      if ($product = $this->db->Select('products', 'id', $v['id_prod'])) {
        $v['product'] = $product['title'];
      } else {
        $v['product'] = 'Магазин';
      }
      $full[] = $v;
    }
    return $full;
  }
  public function allow($id)
  {
    $this->db->Update('feedbacks', ['allow' => 1], 'id', $id);
  }
  public function drop($id)
  {
    $this->db->Update('feedbacks', ['allow' => 0], 'id', $id);
  }
}
