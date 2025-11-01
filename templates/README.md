## Убираем буквы из шаблона статусов пользователя {{ STAUS }} в Remnawave.

 Данный скрипт скачает из репозитория файл **user-statuses.ts** и заменит им файл **user-statuses.ts** в контейнере **remnawave**.

> [!TIP]
> Перезапуск контейнера не требуется, изменения происходят 'на лету'.

При пересоздании контейнера изменения будут отменены и файл user-statuses.ts вернется к оригинальному состоянию.

При обновлении контейнера файл user-statuses.ts будет соответствовать актуальному файлу из официального репозитория remnawave.

**Команда для скачивания и запуска скрипта обновления сниппетов в для умного редактора шаблонов:**

```bash
curl -fsSL https://raw.githubusercontent.com/RomanTrifanov/Remnawave_custom/refs/heads/main/templates/update_user_statuses_icons.sh | bash -
```
