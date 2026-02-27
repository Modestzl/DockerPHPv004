<?php
// Базовый preload файл
$files = /* ваш список файлов для предзагрузки */ [];

foreach ($files as $file) {
    if (file_exists($file)) {
        opcache_compile_file($file);
    }
}
