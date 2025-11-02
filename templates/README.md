### Убираем слова 'Active', 'Expired', 'Disabled', 'Limited' из шаблона статусов пользователя {{ STATUS }} в Remnawave.


Данный скрипт скачает из репозитория файл **user-statuses.mod** в директорию **/opt/remnawave/** и заменит им файл **user-statuses.js** в контейнере **remnawave**.

Если ваш контейнер имеет другое имя или директория отличается от /opt/remnawave/ - измените скрипт.

>[!WARNING]
>
> Вы должны понимать, что делаете!
>


Контейнер **remnawave** будет перезапущен командой `docker restart`

**Команда для скачивания и запуска скрипта**

```bash
curl -fsSL https://raw.githubusercontent.com/RomanTrifanov/Remnawave_custom/refs/heads/main/templates/update_user_statuses_icons.sh | bash -
```

При пересоздании контейнера командой `docker compose down && docker compose up -d` или обновлении, изменения будут отменены и файл **user-statuses.js** вернется к оригинальному состоянию и будет соответствовать актуальному файлу из официального репозитория remnawave.

Для сохранения изменений придется примонтировать модифицированный файл **user-statuses.mod**в контейнер **remnawave**

```
        volumes:
            - ./user-statuses.mod:/opt/app/dist/libs/contract/constants/templates/user-statuses.js
```

Добавьте параметр **volumes** в свой **docker-compose.yml** в секцию **remnawave**, как показано ниже

```
...
    remnawave:
        image: remnawave/backend:latest
        container_name: 'remnawave'
        hostname: remnawave
        restart: always
        ports:
            - '127.0.0.1:3000:3000'
        env_file:
            - .env
        networks:
            - remnawave-network
        depends_on:
            remnawave-db:
                condition: service_healthy
            remnawave-redis:
                condition: service_healthy

# Внесенные изменения
        volumes:
            - ./user-statuses.mod:/opt/app/dist/libs/contract/constants/templates/user-statuses.js
...
```
