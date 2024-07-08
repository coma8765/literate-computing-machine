# TODO App


## Futures (Фичи)
- Просмотр списка задач
- Создание/редактирование задачи
- Переход между страницами
- Удаление элемента, через смахивание
- Логгирование и crash-reports через сервис Sentry
- Подключён API
- Подключено локальное хранение данных
- Статус есть ли интернет, через иконку рядом с названием главной страницы
- Синхронизация данных каждые 30сек
- Повтораная попытка отправить пакеты в случае серверных или сетевых ошибок по экспонентному времени

### Архитектура
- Layer-first Архитектура
- Работа с данными выделена в отдельный пакеты
  - ./packages/local_storage_todos_api
  - ./packages/remote_storage_todos_api
  - ./packages/network_state_provider
  - ./packages/todos_api
  - ./packages/todos_repository

### Тестирование
- Тестрование локального API
- Тестрование удалённого API

## APK файлы
Тут [релиз](https://github.com/coma8765/literate-computing-machine/releases/tag/part-03).

## Screenshots
![home-page-screen-light.png](docs/images/home-page-screen-light.png)
![home-page-screen-light.png](docs/images/home-page-screen-dark.png)
![todo-page-screen-dark.png](docs/images/todo-page-screen-dark.png)
![todo-page-screen-light.png](docs/images/todo-page-screen-light.png)
