# План объяснения проекта Experteese

Цель файла: дать следующему агенту структуру завтрашнего объяснения проекта. Перед разговором нужно прочитать этот файл, `next.md` и `ruby_project_plan.txt`.

## 1. Начать с общей картины

- Объяснить, что `Experteese` - Rails-приложение для экспертной оценки изображений.
- Пользователь выбирает тему/художника, листает изображения, ставит оценку от 5 до 100.
- Приложение хранит оценки пользователей и пересчитывает среднюю оценку изображения.
- Текущий стек: Ruby on Rails, PostgreSQL, Haml, Sass/Bootstrap, jQuery/AJAX, I18n, RSpec/Minitest, Railway.

## 2. Показать маршрут пользовательского сценария

Разобрать основной flow по страницам:

- `/` - главная страница с описанием проекта.
- `/help`, `/about`, `/contacts` - статические информационные страницы.
- `/work` - рабочая область оценки изображений.
- `/signup` - регистрация.
- `/login` и `/logout` - вход и выход.
- `/users/:id` - личный профиль со статистикой.
- `/api/next_image`, `/api/prev_image` - JSON endpoints для AJAX-листания.

Важно объяснить, что локаль сохраняется через `ApplicationController#set_locale`, а ссылки получают `locale` через `default_url_options`.

## 3. Объяснить MVC-архитектуру

### Models

- `User` - пользователь: имя, email, пароль через `has_secure_password`, remember token.
- `Theme` - тема оценки, фактически вопрос про художника.
- `Image` - изображение: название, имя файла, тема, средняя оценка `ave_value`.
- `Value` - оценка пользователя: `user_id`, `image_id`, `value`.

Отдельно объяснить:

- связи `has_many`, `belongs_to`;
- уникальность оценки пользователя для одного изображения;
- ограничение оценки `5..100`;
- callback `Value#refresh_image_average`, который обновляет среднюю оценку после создания оценки.

### Controllers

- `MainController` - статические страницы.
- `WorkController` - собирает темы, выбранную тему, изображения и первую текущую картинку.
- `Api::ApiController` - возвращает JSON для next/prev изображения.
- `UsersController` - регистрация и профиль.
- `SessionsController` - вход/выход.
- `ValuesController` - сохранение оценки, защита от анонимных пользователей и повторных оценок.
- `ApplicationController` - локализация и подключение session helper.

### Views

- `app/views/layouts/application.html.haml` - общий layout.
- `app/views/shared/_header.html.haml` - навигация, login/profile, переключение языка.
- `app/views/shared/_footer.html.haml` - footer.
- `app/views/main/*` - статические страницы.
- `app/views/work/index.html.haml` - основная рабочая область.
- `app/views/users/*`, `app/views/sessions/*` - формы аккаунта и профиль.

## 4. Объяснить данные и seeds

- `db/migrate/*` - структура таблиц.
- `db/schema.rb` - актуальная схема БД.
- `db/seeds.rb` - стартовые темы, 12 изображений и sample user.
- `assets/images/pictures` - локальные изображения для seed-данных.
- `config/initializers/assets.rb` - регистрация папки с изображениями в asset pipeline.

Важно: seed-файл idempotent, он не должен удалять данные.

## 5. Объяснить JavaScript и AJAX

- `app/assets/javascripts/jquery.js` - локальный jQuery.
- `app/assets/javascripts/work.js` - обработчики кнопок previous/next.
- `work.js` читает `data-*` атрибуты из `work/index.html.haml`.
- API возвращает `image_url`, `name`, `common_ave_value`, `user_valued`, `value`.
- JS обновляет картинку, название, счетчик и hidden `image_id` без перезагрузки страницы.

## 6. Объяснить локализацию

- `config/application.rb` задает `available_locales = [:en, :ru]`.
- `config/locales/ru.yml` и `config/locales/en.yml` содержат тексты интерфейса.
- В header есть переключатель EN/RU.
- Названия seed-тем локализуются через helper в `ApplicationHelper`.
- Повторная оценка выводит локализованное сообщение из `controllers.values.already_rated`.

## 7. Объяснить аутентификацию

- Пароли хранятся через `password_digest` и `bcrypt`.
- `SessionsHelper` содержит `sign_in`, `current_user`, `signed_in?`, `sign_out`.
- `ValuesController` не дает отправлять оценки без входа.
- `UsersController#show` защищает профиль: пользователь видит только свою страницу.

## 8. Объяснить профиль и статистику

- `UsersController#show` собирает:
  - общее число оценок;
  - число оцененных изображений;
  - число связанных тем;
  - историю оценок;
  - оценки в пределах 25% от среднего значения изображения.
- Scope `Value.within_twenty_five_percent_of_image_average` делает выборку по условию отклонения.

## 9. Объяснить тесты и качество

- `spec/models/*` - RSpec model specs.
- `spec/requests/*` - request specs для основных сценариев.
- `test/controllers/*` и `test/models/*` - оставшиеся Minitest regression tests.
- `.rubocop.yml` - стиль.
- `brakeman` - security scan.
- `simplecov` - coverage для RSpec.
- `.github/workflows/ci.yml` - CI на GitHub Actions.

Перед объяснением полезно упомянуть последние успешные проверки:

- `bundle exec rspec`
- `bundle exec rails test`
- `bundle exec rubocop --format simple`
- `bundle exec brakeman --quiet --no-pager --exit-on-warn --exit-on-error`

## 10. Объяснить деплой

- GitHub remote: `https://github.com/slavikfish03/experteese.git`.
- Railway деплоит проект из GitHub.
- `Dockerfile` описывает production container.
- `bin/docker-entrypoint` запускает `rails db:prepare` перед server boot.
- Railway PostgreSQL подключается через `DATABASE_URL`.
- `RAILS_MASTER_KEY` задается в Railway Variables, не хранится в Git.
- Public domain создается в Railway service settings через Public Networking.

## 11. Предложенный порядок живого объяснения

1. Открыть главную страницу и показать навигацию.
2. Переключить RU/EN и объяснить I18n.
3. Открыть `/work`, выбрать тему, перелистнуть изображения.
4. Зарегистрироваться или войти sample user.
5. Поставить оценку и показать защиту от повторной оценки.
6. Открыть профиль и объяснить статистику.
7. Перейти в код и пройти по маршруту request -> controller -> model -> view.
8. Показать тесты, seeds, routes и deployment files.

## 12. Команды для демонстрации

```powershell
git status --short --branch
bundle exec rails routes
bundle exec rspec
bundle exec rails test
bundle exec rubocop --format simple
```

Для локального запуска нужны стандартные env vars из `next.md`, включая `POSTGRES_PASSWORD` для локального PostgreSQL.

