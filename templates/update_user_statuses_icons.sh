#!/bin/bash

# Проверяем наличие запущенного контейнера 'remnawave'
CONTAINER=$(docker ps --format "{{.Names}}" | grep ^remnawave$ )

# Проверка наличия контейнеров
if [[ -z "$CONTAINER" ]]; then
    echo "Контейнер с именем 'remnawave' не найден."
    exit 1
fi

# Скачиваем файл user-statuses.ts
curl -sSL https://raw.githubusercontent.com/RomanTrifanov/Remnawave_custom/refs/heads/main/templates/user-statuses.ts \
     -o user-statuses.ts || { echo "Ошибка загрузки файла!"; exit 1; }

# Копируем файл в целевой контейнер
docker cp user-statuses.ts "${CONTAINER}:/opt/app/libs/contract/constants/templates/user-statuses.ts" || {
    echo "Ошибка копирования файла в контейнер!"
    exit 1
}

# && rm user-statuses.ts 

echo "Файл user-statuses.ts успешно заменён внутри контейнера ${CONTAINER}"
