<?php

require_once('models/Feedback.php');

$list = new Feedback;

if(isset($_GET['id']) && $_GET['act'] == 'allow') {
  $list->allow($_GET['id']);
}

if(isset($_GET['id']) && $_GET['act'] == 'drop') {
  $list->drop($_GET['id']);
}


$feedbacks = $list->getAll();

$data = array('feedbacks' => $feedbacks);
