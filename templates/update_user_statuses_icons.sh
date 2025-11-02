#!/bin/bash

# Проверяем наличие запущенного контейнера 'remnawave'
CONTAINER=$(docker ps --format "{{.Names}}" | grep ^remnawave$ )

# Проверка наличия контейнеров
if [[ -z "$CONTAINER" ]]; then
    echo "Контейнер с именем 'remnawave' не найден."
    exit 1
fi

# Скачиваем файл user-statuses.mod

cd /opt/remnawave/

curl -sSL https://raw.githubusercontent.com/RomanTrifanov/Remnawave_custom/refs/heads/main/templates/user-statuses.mod \
     -o user-statuses.mod || { echo "Ошибка загрузки файла!"; exit 1; }

# Копируем оригинальный файл из контейнер (резервная копия)
docker cp "${CONTAINER}:/opt/app/dist/libs/contract/constants/templates/user-statuses.js" ./user-statuses.js.origin_$(date +%Y-%m-%d_%H-%M-%S)

# Копируем модифицированный файл в целевой контейнер
docker cp user-statuses.mod "${CONTAINER}:/opt/app/dist/libs/contract/constants/templates/user-statuses.js" || {
    echo "Ошибка копирования файла в контейнер!"
    exit 1
}

echo "Файл user-statuses.js успешно заменён внутри контейнера ${CONTAINER}, перезапускаю контейнер"

# Перезапускаем контейнер для применения изменения

docker restart ${CONTAINER}
