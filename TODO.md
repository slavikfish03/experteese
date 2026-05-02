# TODO: Experteese Course Project

## Summary

Experteese is planned as a Ruby on Rails web application for collecting expert ratings of images and calculating an average qualified score from community input. The stack is fixed by the course plan: Ruby 3.3.0+, Rails 7.1.2+, PostgreSQL, Haml, Sass, Bootstrap, jQuery/AJAX, Git/GitHub, and deployment to Railway or Heroku.

The implementation should follow the laboratory sequence from the course. Each iteration maps to one or more labs: project skeleton and PostgreSQL setup, static pages and layout, Active Record models, work area for image evaluation, JSON API with AJAX navigation, authentication, I18n, personal statistics page, quality checks, and deployment.

The repository now contains a Rails 8.1.x application skeleton in the root, planning/instruction files, and lab reference snippets under `labs/`. Tasks that depend on lab code are tracked as reference-assisted implementation points rather than direct code imports.

## Current Repository Artifacts

| Path | Status | Planned use |
|---|---|---|
| `ruby_project_plan.txt` | Present | Primary source for project scope, architecture, iterations, testing, and acceptance criteria. |
| `AGENTS.md` | Present | Local coding and safety instructions for future implementation work. |
| `PLANS.md` | Present | Reference for ExecPlans if a later implementation step becomes a complex feature or refactor. |
| `labs/*.txt` | Present | Supplemental lab snippets for architecture, models, DB setup, SPA/API, auth, and I18n; use as reference material, not as drop-in project code. |
| Rails app files | Present | Rails 8.1.x application skeleton is generated in the repository root and configured for PostgreSQL. |
| Full Lab 1-10 project code | Missing | User confirmed only lab snippets are available under `labs/`; implementation must adapt them into the project. |
| `.git` repository | Present | Git repository is initialized in `D:\RUBY_PROJECT`. |

## Task Format

- Priority: P0 critical, P1 important, P2 useful.
- Effort: small, medium, large.
- Dependencies: previous project tasks or lab artifacts.
- Acceptance: concrete verification for a future implementation pass.

## Iteration 0: Clarification and Inputs

### Status

| Task | Status | Resolution |
|---|---|---|
| `T0.1` | Done | Rails project should live directly in `D:\RUBY_PROJECT` as the application root. |
| `T0.2` | Done | Available lab material is located in `D:\RUBY_PROJECT\labs` and consists of reference snippets, not ready project code. |
| `T0.3` | Done | Deployment target is `Railway`. |
| `T0.4` | Done | Seed images should be stored as local repository files in `assets/images/pictures`, referenced by filename in `db/seeds.rb`, and exposed through `config/initializers/assets.rb`. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T0.1 | Confirm whether the Rails project should be generated directly in `D:\RUBY_PROJECT` or in a nested app directory. | Repository root | Resolved from `NOTES.md` answer `B1` | P0 | small | Target project location is explicitly recorded before `rails new`. |
| T0.2 | Request available laboratory code for Labs 1-10, or confirm that implementation should start from scratch. | External lab files | Resolved from `NOTES.md` answer `B2` | P0 | small | User provides lab paths/files or confirms they are unavailable. |
| T0.3 | Choose deployment target: Railway or Heroku. | Deployment config | Resolved from `NOTES.md` answer `B7` | P1 | small | Deployment platform is selected before Iteration 10. |
| T0.4 | Confirm image storage strategy for seed images: remote URLs, local assets, or uploaded files. | `assets/images/pictures`, `config/initializers/assets.rb`, `db/seeds.rb` | Resolved from user clarification | P1 | small | Seed images are defined as local repository files and the integration path is explicitly recorded. |

## Iteration 1: Environment and Rails Skeleton

### Status

| Task | Status | Resolution |
|---|---|---|
| `T1.1` | Done | Rails application skeleton is generated in `D:\RUBY_PROJECT` with PostgreSQL selected as the database adapter. |
| `T1.2` | Done | Project uses `Ruby 3.4.8`; generated `Gemfile` resolved to Rails `8.1.3`, which satisfies the allowed `8.1.x` implementation choice. |
| `T1.3` | Done | Git is initialized in `D:\RUBY_PROJECT` and `.gitignore` is present. |
| `T1.4` | Done | `config/database.yml` is configured for local PostgreSQL, PostgreSQL 18.3 connectivity is verified, and `experteese_development` / `experteese_test` were created. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T1.1 | Create or integrate Rails 7.1.2+ project with PostgreSQL. | `Gemfile`, `config/database.yml`, Rails app structure | T0.1, Lab 1 code if available | P0 | medium | Rails app exists and is configured for PostgreSQL in development/test. |
| T1.2 | Verify Ruby and Rails versions against course constraints. | `.ruby-version`, `Gemfile`, environment docs | T1.1 | P0 | small | Ruby is 3.3.0+ and the project Rails version is pinned to a course-compatible release (`7.1.2+`, preferably `7.1.x` for lab compatibility). |
| T1.3 | Initialize Git repository if missing. | `.git`, `.gitignore` | T1.1 | P1 | small | `git status` works and generated temporary files are ignored. |
| T1.4 | Prepare base database setup. | `config/database.yml`, local PostgreSQL database | T1.1 | P0 | small | Development and test databases can be created in a future implementation pass, and PostgreSQL client/server access is available locally. |

## Iteration 2: Static Pages and UI Foundation

### Status

| Task | Status | Resolution |
|---|---|---|
| `T2.1` | Done | `MainController` and Haml static pages for `index`, `help`, `about`, and `contacts` are implemented. |
| `T2.2` | Done | The application layout was converted to `app/views/layouts/application.html.haml`, and the ERB layout was removed. |
| `T2.3` | Done | Shared Haml partials for the header and footer are rendered by the main layout. |
| `T2.4` | Done | Bootstrap 5, Font Awesome, Haml, and Dart Sass are integrated through the Rails asset pipeline. |
| `T2.5` | Done | Base navigation links route to the static pages and expose placeholders for future Work/Login/Profile entry points. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T2.1 | Create `Main` controller with static pages. | `app/controllers/main_controller.rb`, `app/views/main/*` | T1.1, Lab 2 code if available | P0 | medium | Routes render Help, About, and Contacts pages. |
| T2.2 | Convert application layout to Haml. | `app/views/layouts/application.html.haml` | T2.1 | P0 | medium | Main layout renders without ERB layout dependency. |
| T2.3 | Add shared header and footer partials. | `app/views/shared/_header.html.haml`, `app/views/shared/_footer.html.haml` | T2.2 | P1 | small | Header/footer appear on static pages. |
| T2.4 | Integrate Bootstrap and Font Awesome according to the Rails asset setup. | `Gemfile` or import map/assets, Sass entrypoints | T1.1 | P1 | medium | Bootstrap grid/components and icons are available in views. |
| T2.5 | Define base navigation links. | Header partial, `config/routes.rb` | T2.1, T2.3 | P1 | small | Navigation reaches static pages and future Work/Login/Profile entry points. |

## Iteration 3: Data Models and Seeds

### Status

| Task | Status | Resolution |
|---|---|---|
| `T3.1` | Done | `User` model and migration include `name`, unique `email`, `password_digest`, and `remember_token`; `bcrypt` and `has_secure_password` are wired in. |
| `T3.2` | Done | `Theme` model and migration store unique rating topic names. |
| `T3.3` | Done | `Image` model and migration store `name`, `file`, `theme_id`, and `ave_value` with a default of `0`. |
| `T3.4` | Done | `Value` model and migration store `user_id`, `image_id`, and integer `value`. |
| `T3.5` | Done | Active Record associations, validations, uniqueness constraints, and helper scopes are defined for the four domain models. |
| `T3.6` | Done | `db/seeds.rb` is idempotent and creates 4 themes, 12 images, and one sample user; 12 local JPEG files exist under `assets/images/pictures`. |
| `T3.7` | Done | `Value#value` is validated as an integer in the `5..100` range. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T3.1 | Create `User` model. | `app/models/user.rb`, migration | T1.1, Lab 3-4 code if available | P0 | medium | User has name, unique email, `password_digest`, and session token fields. |
| T3.2 | Create `Theme` model. | `app/models/theme.rb`, migration | T1.1 | P0 | small | Theme stores the rating topic name. |
| T3.3 | Create `Image` model. | `app/models/image.rb`, migration | T3.2 | P0 | medium | Image stores title, file/link reference, `theme_id`, and `ave_value`. |
| T3.4 | Create `Value` model for ratings. | `app/models/value.rb`, migration | T3.1, T3.3 | P0 | medium | Value stores `user_id`, `image_id`, and numeric rating. |
| T3.5 | Define Active Record associations and validations. | `User`, `Theme`, `Image`, `Value` models | T3.1-T3.4 | P0 | medium | Associations match the domain: users/images have many values, images belong to themes. |
| T3.6 | Prepare seed data with at least 3 themes and 10 images. | `assets/images/pictures`, `config/initializers/assets.rb`, `db/seeds.rb` | T0.4, T3.2, T3.3 | P1 | medium | Seed run can populate minimum dataset without duplicate/conflicting records, and image filenames resolve through the configured asset path. |
| T3.7 | Define rating scale constraints. | `Value` validation, UI notes | Resolved from `NOTES.md` answer `B3` | P0 | small | Rating values are enforced as integers in the `5..100` range. |

## Iteration 4: Expert Work Area

### Status

| Task | Status | Resolution |
|---|---|---|
| `T4.1` | Done | `WorkController#index` and `/work` route render the expert work area. |
| `T4.2` | Done | The work page includes a `select_tag` theme selector submitted through `GET /work`. |
| `T4.3` | Done | The page displays the selected theme's first image title, visual asset, and current average value. |
| `T4.4` | Done | A rating form shell is present with `image_id` and a `5..100` numeric input; submission remains disabled until authentication/rating actions are implemented. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T4.1 | Create `WorkController#index`. | `app/controllers/work_controller.rb`, route | T2.5, T3.2, T3.3, Lab 5-6 code if available | P0 | medium | `/work` renders the expert work area. |
| T4.2 | Add theme selector. | `app/views/work/index.html.haml` | T4.1, T3.2 | P0 | small | User can select a theme with `select_tag`. |
| T4.3 | Display current image for selected theme. | Work view, controller query | T4.1, T3.3 | P0 | medium | Page shows image title and visual content for selected theme. |
| T4.4 | Plan rating input UI. | Work view, Value model | T3.4, T3.7 | P1 | medium | UI can submit a rating for the visible image once authentication is available. |

## Iteration 5: API and AJAX Image Navigation

### Status

| Task | Status | Resolution |
|---|---|---|
| `T5.1` | Done | API namespace routes are available for `/api/next_image` and `/api/prev_image`. |
| `T5.2` | Done | `Api::ApiController#next_image` returns JSON for the next image in the selected theme. |
| `T5.3` | Done | `Api::ApiController#prev_image` returns JSON for the previous image in the selected theme. |
| `T5.4` | Done | Local jQuery and `work.js` update the work-area image, title, index, average value, and hidden `image_id` without reloading the page. |
| `T5.5` | Done | Controller tests verify cyclic wrap behavior for next-after-last and previous-before-first. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T5.1 | Create API namespace and controller. | `app/controllers/api/api_controller.rb`, `config/routes.rb` | T4.1, Lab 5-6 code if available | P0 | medium | JSON routes exist under an API namespace. |
| T5.2 | Implement `next_image` endpoint. | `Api::ApiController` | T5.1, T3.3 | P0 | medium | Endpoint returns next image data as JSON for a theme/current image. |
| T5.3 | Implement `prev_image` endpoint. | `Api::ApiController` | T5.1, T3.3 | P0 | medium | Endpoint returns previous image data as JSON for a theme/current image. |
| T5.4 | Add jQuery/AJAX client behavior. | JavaScript asset/import, Work view | T5.2, T5.3 | P0 | medium | Next/previous controls update image data without page reload. |
| T5.5 | Define boundary behavior for first/last image. | API/controller tests or manual scenario | Resolved from `NOTES.md` answer `B4` | P1 | small | Navigation wraps cyclically: next after last returns first, prev before first returns last. |

## Iteration 6: Authentication and Registration

### Status

| Task | Status | Resolution |
|---|---|---|
| `T6.1` | Done | `bcrypt`, `has_secure_password`, `password_digest`, password length validation, and password authentication are wired in `User`. |
| `T6.2` | Done | `UsersController`, `/signup`, user create/show routes, and Haml registration/profile views are implemented. |
| `T6.3` | Done | Existing email regex and case-insensitive uniqueness validation reject invalid and duplicate emails. |
| `T6.4` | Done | `SessionsController` and `/login`/`/logout` routes allow sign in and sign out. |
| `T6.5` | Done | `SessionsHelper` provides `sign_in`, `current_user`, `signed_in?`, and `sign_out`, included in `ApplicationController`. |
| `T6.6` | Done | `UsersHelper#gravatar_for` renders Gravatar on the user profile page. |
| `T6.7` | Done | `ValuesController#create` requires authentication; `/work` disables anonymous rating submit; API payload includes current user's rating state. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T6.1 | Enable `has_secure_password`. | `Gemfile`, `app/models/user.rb` | T3.1, Lab 7 code if available | P0 | medium | User password can be set and authenticated through Rails conventions. |
| T6.2 | Create registration flow. | `UsersController`, user views, routes | T6.1 | P0 | medium | New user can register with name, email, and password. |
| T6.3 | Add email validation. | `User` model | T6.2 | P0 | small | Invalid email is rejected and duplicate email is prevented. |
| T6.4 | Create sessions flow. | `SessionsController`, login/logout views, routes | T6.1 | P0 | medium | User can sign in and sign out. |
| T6.5 | Create `SessionsHelper`. | `app/helpers/sessions_helper.rb`, controller integration | T6.4 | P0 | medium | `sign_in` and `current_user` work consistently. |
| T6.6 | Integrate Gravatar. | User helper/view | T6.2 | P2 | small | User avatar renders from email hash where needed. |
| T6.7 | Restrict rating actions to authenticated users. | Work/API controllers | T4.4, T6.5 | P0 | medium | Anonymous users cannot submit ratings. |

## Iteration 7: Localization

### Status

| Task | Status | Resolution |
|---|---|---|
| `T7.1` | Done | `config/application.rb` declares available locales `:en` and `:ru`, default `:en`, and English fallback. |
| `T7.2` | Done | `config/locales/en.yml` and `config/locales/ru.yml` contain translations for static pages, navigation, auth, work area labels, flash messages, and user form labels. |
| `T7.3` | Done | Header includes EN/RU locale links that switch the current page through `locale_switch_path`. |
| `T7.4` | Done | `ApplicationController#set_locale` stores valid locale params in session and `default_url_options` preserves locale across generated links/forms. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T7.1 | Configure available locales. | `config/application.rb`, locale config | T2.2, Lab 8 code if available | P1 | small | Russian and English locales are available. |
| T7.2 | Create translation files. | `config/locales/ru.yml`, `config/locales/en.yml` | T7.1 | P1 | medium | Static pages, navigation, auth, and work area labels use I18n keys. |
| T7.3 | Add locale switching in header. | Header partial, routes/controller locale handling | T7.1, T2.3 | P1 | medium | User can switch Russian/English through header flag links. |
| T7.4 | Preserve selected locale across navigation. | Application controller, URL params/session | T7.3 | P1 | medium | Locale does not reset unexpectedly between pages. |

## Iteration 8: User Profile and Rating Statistics

### Status

| Task | Status | Resolution |
|---|---|---|
| `T8.1` | Done | `Users#show` is protected by authentication and limited to the current user's own profile page. |
| `T8.2` | Done | The profile page shows total ratings, rated image/theme counts, and a table of submitted ratings with related image and theme names. |
| `T8.3` | Done | `Value.within_twenty_five_percent_of_image_average` selects ratings whose absolute deviation from `Image#ave_value` is no more than 25%, and the profile renders that table. |
| `T8.4` | Done | The existing `Value#after_create` callback remains the chosen recalculation path; focused model coverage now verifies immediate average refresh. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T8.1 | Create `Users#show`. | `UsersController`, `app/views/users/show.html.haml`, route | T6.2 | P0 | medium | Authenticated user can open personal page. |
| T8.2 | Show rating statistics. | `Users#show`, `Value` queries | T3.4, T8.1 | P0 | medium | Page shows user's rating count and related images/themes. |
| T8.3 | Implement 25% deviation query. | `Value` scope/query object or controller query | T3.3, T3.4, T8.2 | P0 | large | Table shows user's ratings deviating no more than 25% from image average. |
| T8.4 | Decide how `Image#ave_value` is recalculated. | `Value` model callback/service/controller | Resolved from `NOTES.md` answer `B5` | P0 | medium | `Image#ave_value` is recalculated immediately after a new `Value` is created for that image. |

## Iteration 9: Quality Control

### Status

| Task | Status | Resolution |
|---|---|---|
| `T9.1` | Done | RuboCop was already present through `rubocop-rails-omakase`; project style offenses were fixed and RuboCop now reports no offenses. |
| `T9.2` | Done | Brakeman was already present and scans successfully with `0` security warnings. |
| `T9.3` | Done | SimpleCov is configured for RSpec and generates `coverage/`, which is ignored by Git. |
| `T9.4` | Done | Focused RSpec model specs cover validations, associations, helper scopes, and average recalculation for `User`, `Theme`, `Image`, and `Value`. |
| `T9.5` | Done | RSpec request specs cover static pages, locale switching, auth, work area, rating submission, API JSON, and profile statistics. |
| `T9.6` | Done | RSpec is selected for new quality checks through `rspec-rails`, `.rspec`, `spec/rails_helper.rb`, generator config, and CI step. Existing Minitest tests remain as regression coverage. |

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T9.1 | Add/configure RuboCop. | `Gemfile`, `.rubocop.yml` | App implementation | P1 | medium | RuboCop can run and style violations are triaged. |
| T9.2 | Add/configure Brakeman. | `Gemfile` or development tools | App implementation | P1 | small | Brakeman can scan the app and high-confidence issues are addressed. |
| T9.3 | Add SimpleCov if tests are introduced. | `spec/spec_helper.rb` or test helper | Test framework decision | P2 | small | Coverage report is generated during test run. |
| T9.4 | Add focused model tests. | `spec/models/*` or `test/models/*` | T3.1-T3.5 | P1 | medium | Validations and associations for core models are covered. |
| T9.5 | Add request/system checks for core flows. | `spec/requests/*`, `spec/system/*` or Rails tests | T4-T8 | P1 | large | Static pages, auth, work area, and AJAX/API behavior have regression coverage. |
| T9.6 | Decide RSpec vs default Rails test framework. | `Gemfile`, test directories | Resolved from `NOTES.md` answer `B6` | P1 | small | `RSpec` is selected as the project test framework. |

## Iteration 10: Deployment

| ID | Task | Files/modules | Dependencies | Priority | Effort | Acceptance |
|---|---|---|---|---|---|---|
| T10.1 | Prepare deployment config for selected platform. | `Dockerfile` for Railway or `Procfile` for Heroku | T0.3, Lab 9 code if available | P0 | medium | Required platform config file exists. |
| T10.2 | Configure production database and secrets. | Platform env vars, Rails credentials | T10.1 | P0 | medium | Production app can connect to PostgreSQL without committing secrets. |
| T10.3 | Run production migrations and seed setup. | Deployment commands, `db/seeds.rb` | T3.6, T10.2 | P0 | small | Production database contains required schema and initial data. |
| T10.4 | Verify production smoke path. | Deployed app URL | T10.1-T10.3 | P0 | small | Main page, login, work area, and locale switch are reachable in production. |

## Active Blockers

| ID | Question | Blocks |
|---|---|---|
| None | No active blockers are open after Iteration 5. | - |

## Answer of B-asks

| ID | Question | Answer | 
| --- | --- | --- | --- |
| **B1** | Where should the Rails app live: repository root or nested directory? | The Git repository should be initialized directly in the root directory of the project (the application's file tree). |
| **B2** | Are lab source files available, and if so where? |All the code available from the lab assignments is located in the /labs folder. IMPORTANT: this is not the project code and not the lab assignment code; these are some code snippets that I managed to obtain.| 
| **B3** | What is the rating scale for `Value#value`? |The grade is assigned on a scale from 5% to 100% (the models use integers, for example, 40 or 85). |
| **B4** | How should image navigation behave at first/last image? |Cyclic scrolling has been implemented: when reaching the last image, navigating forward loops back to the first (index 0), and when navigating backward from the first, it jumps to the last.|
| **B5** | How and when should `Image#ave_value` be recalculated? | The average value must be recalculated immediately after a new rating (Value) is created for the given image. |
| **B6** | Should tests use RSpec or the default Rails test framework? |The course recommends using RSpec, as it is considered a more concise and descriptive tool. |
| **B7** | Should deployment target Railway or Heroku? | The target platform is Railway, since Heroku has discontinued its free tier plans. |
| **B8** | What image storage strategy should be used for seed images: remote URLs, local assets, or uploaded files? | Use local repository files placed in `assets/images/pictures`; register that path in `config/initializers/assets.rb`; store only the image filename in `db/seeds.rb`; render via `image_tag`. |
| **B9** | Should the project be pinned to Rails `7.1.x` for maximum compatibility with the course labs, or is Rails `8.1.2` acceptable for implementation? | Implementation on Rails `8.1.x` is allowed. The generated project currently resolves to Rails `8.1.3`. |
| **B10** | PostgreSQL client tools are not visible in `PATH` (`psql` not found). Is PostgreSQL already installed elsewhere, or should local setup be planned as part of implementation? | PostgreSQL 18.3 is installed under `D:\Program Files\PostgreSQL\18`, the service is running, and connectivity works through the direct `psql.exe` path. |
