<?php

declare(strict_types = 1);
declare(ticks = 100);
error_reporting(E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_ERROR | E_WARNING | E_PARSE | E_USER_ERROR | E_USER_WARNING | E_RECOVERABLE_ERROR);
set_time_limit(0);
umask(0);
date_default_timezone_set('UTC');
session_cache_limiter('nocache');

$rootPath = realpath(dirname(__FILE__));
require_once $rootPath.'/vendor/autoload.php';