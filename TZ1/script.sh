#!/bin/bash


if [ $# -lt 1 ]; then
  echo "Необходимо указать исходную директорию"
  exit 1
fi

otkuda_fail=$1
kuda_kopir=${2:-"$(dirname "$otkuda_fail")/$(basename "$otkuda_fail")_copy"}

# Создаем целевую директорию, если она не существует
mkdir -p "$kuda_kopir"

# Используем find с пайпом в while для безопасной обработки имен файлов
find "$otkuda_fail" -type f | while IFS= read -r i; do
  cou=0
  c=''
  filename=$(basename -- "$i")
  newpath="$kuda_kopir/$filename"
  
  # Находим уникальное имя для файла
  while [[ -e $newpath ]]; do
    ((cou++))
    newpath="$kuda_kopir/${cou}_$filename"
  done
  
  # Копируем файл
  cp "$i" "$newpath"
done
