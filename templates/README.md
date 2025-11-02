### Убираем слова 'Active', 'Expired', 'Disabled', 'Limited' из шаблона статусов пользователя {{ STATUS }} в Remnawave.

<img width="300" height="138" alt="Снимок экрана от 2025-11-02 15-01-34" src="https://github.com/user-attachments/assets/0406d8bc-b87e-4933-bfb9-fd76defba19c" /> <img width="299" height="138" alt="Снимок экрана от 2025-11-02 14-57-25" src="https://github.com/user-attachments/assets/c5d9e9b3-26af-4b8c-85ea-458a5c25d835" />



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

> [!TIP]
> Если это то, чего Вам очень не хватало - можете поддержать автора )
> 
> Часть средств пойдет в поддержку Remnawave
> 
> **Крипта**:
> 
>- USDT (TRC20) ```TXRt5vuc4E32XCwkBQvykFUDZQnqnTLhdK```
><img width="160" height="160" alt="Снимок экрана от 2025-11-02 14-09-37" src="https://github.com/user-attachments/assets/41fa43c5-d995-4cf3-aa3d-a1241996b8e1" />
>
>----------
>- USDT (TON) ```UQB2LfFr7MfUDCn-m3f9uWwLMNsnnfljyS7p0JRIe-bvn8T9```
><img width="160" height="160" alt="Снимок экрана от 2025-11-02 14-10-49" src="https://github.com/user-attachments/assets/53a44ed2-a52b-4dbb-b315-97e983a83224" />
>
>----------
>- Toncoin (TON) ```UQB2LfFr7MfUDCn-m3f9uWwLMNsnnfljyS7p0JRIe-bvn8T9```
><img width="160" height="160" alt="Снимок экрана от 2025-11-02 14-30-47" src="https://github.com/user-attachments/assets/21497acf-9ea3-4b2c-a93c-6719bc94f628" />
>
>----------
>- Solana (SOL) ```FoBcJc8WRh7PAr6FN4UmFsm8rpZrhHfx44F7j8SurEM7```
><img width="160" height="160" alt="Снимок экрана от 2025-11-02 14-13-53" src="https://github.com/user-attachments/assets/0e9be946-9e61-4fa2-92a2-1ece8c7e578c" />
>
>----------
> **Т-Банк**
>
>- https://www.tbank.ru/cf/9qIrMkXPGlO
>
><img width="160" height="160" alt="Снимок экрана от 2025-11-02 14-23-54" src="https://github.com/user-attachments/assets/f388a4d8-2d95-4d50-a0db-216ff64d3a80" />
