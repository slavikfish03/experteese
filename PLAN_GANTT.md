# Roadmap and Text Gantt

## Execution Order

| Iteration | Scope | Depends on | Milestone |
|---|---|---|---|
| 0 | Clarifications and lab artifact collection | `ruby_project_plan.txt`, user input | Implementation inputs are known. |
| 1 | Environment and Rails skeleton | Iteration 0 | Rails app can be generated/integrated with PostgreSQL. |
| 2 | Static pages and UI foundation | Iteration 1 | Layout, navigation, Haml, Bootstrap base are ready. |
| 3 | Data models and seeds | Iteration 1 | Domain schema exists for users, themes, images, and ratings. |
| 4 | Expert work area | Iterations 2-3 | User can view an image within a selected theme. |
| 5 | API and AJAX navigation | Iteration 4 | Image navigation works without full page reload. |
| 6 | Authentication | Iteration 3, partially Iteration 4 | Registration, login, current user, and protected rating actions are available. |
| 7 | Localization | Iteration 2, preferably after auth/work labels exist | Russian and English UI are switchable. |
| 8 | User profile and statistics | Iterations 3, 6 | Personal page shows ratings and 25% deviation table. |
| 9 | Quality control | Stable implementation from Iterations 1-8 | Lint, security scan, and selected tests are passing or triaged. |
| 10 | Deployment | Iterations 1-9, deployment target decision | App is deployed with production database and seed data. |

## Text Gantt

Legend: `###` active implementation window, `M` milestone/checkpoint.

| Workstream | I0 | I1 | I2 | I3 | I4 | I5 | I6 | I7 | I8 | I9 | I10 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Clarifications and lab inputs | ### M | | | | | | | | | | |
| Rails skeleton and PostgreSQL | | ### M | | | | | | | | | |
| Static pages, layout, assets | | | ### M | | | | | | | | |
| Models, migrations, seeds | | | | ### M | | | | | | | |
| Work area UI | | | | | ### M | | | | | | |
| JSON API and AJAX | | | | | | ### M | | | | | |
| Auth and sessions | | | | | | | ### M | | | | |
| I18n | | | | | | | | ### M | | | |
| Profile and statistics | | | | | | | | | ### M | | |
| Quality checks and tests | | | | | | | | | | ### M | |
| Production deployment | | | | | | | | | | | ### M |

## Key Checkpoints

| Checkpoint | After iteration | Required evidence |
|---|---|---|
| C1: App baseline | 1 | Rails app structure exists, PostgreSQL configured, Git initialized. |
| C2: UI baseline | 2 | Static pages render through Haml layout with header/footer. |
| C3: Domain baseline | 3 | Migrations/models/seeds represent User, Theme, Image, Value. |
| C4a: Work area baseline | 4 | `/work` renders theme selection, the current image, and prepared rating controls. |
| C4: Evaluation workflow | 5 | Theme selection and next/previous image navigation work through jQuery AJAX. |
| C5: Authenticated workflow | 6 | User can register, log in, and access protected rating behavior. |
| C6: Course completeness | 8 | Localization and personal statistics page cover remaining functional labs. |
| C7: Release candidate | 9 | Quality tools and selected tests are run and issues are resolved or documented. |
| C8: Production | 10 | App is deployed and smoke-tested. |

## Iteration 0 Resolution

| Task | Result |
|---|---|
| `T0.1` | App root is `D:\RUBY_PROJECT`. |
| `T0.2` | Lab reference materials are available under `D:\RUBY_PROJECT\labs`. |
| `T0.3` | Deployment target is `Railway`. |
| `T0.4` | Seed images should come from local repository files in `assets/images/pictures`, wired through `config/initializers/assets.rb` and referenced by filename in `db/seeds.rb`. |

## Iteration 1 Readiness

| Task | Result |
|---|---|
| `T1.1` | Completed. Rails application skeleton is present in `D:\RUBY_PROJECT` and uses PostgreSQL. |
| `T1.2` | Completed. Project runs on `Ruby 3.4.8` and Rails `8.1.3`. |
| `T1.3` | Completed. Git repository is initialized and `.gitignore` is configured. |
| `T1.4` | Completed. PostgreSQL connectivity is verified and the development/test databases were created. |

## Iteration 2 Readiness

| Task | Result |
|---|---|
| `T2.1` | Completed. `MainController` and the static pages for `/`, `/help`, `/about`, and `/contacts` are implemented. |
| `T2.2` | Completed. The application layout now renders from `application.html.haml`. |
| `T2.3` | Completed. Shared header and footer partials are wired into the layout. |
| `T2.4` | Completed. Bootstrap 5, Font Awesome, Haml, and Dart Sass are installed and the Sass bundle builds successfully. |
| `T2.5` | Completed. Navigation links cover the static pages and reserve entry points for future authenticated flows. |

## Iteration 3 Readiness

| Task | Result |
|---|---|
| `T3.1` | Completed. `User` has `name`, unique `email`, `password_digest`, and `remember_token`, with `has_secure_password` available. |
| `T3.2` | Completed. `Theme` stores unique rating topic names. |
| `T3.3` | Completed. `Image` stores `name`, unique local asset filename, `theme_id`, and `ave_value`. |
| `T3.4` | Completed. `Value` stores `user_id`, `image_id`, and integer rating value. |
| `T3.5` | Completed. Associations and validations are implemented across `User`, `Theme`, `Image`, and `Value`. |
| `T3.6` | Completed. Idempotent seeds create the baseline user, themes, and 12 local image records backed by JPEG files. |
| `T3.7` | Completed. Ratings are constrained to integer values from `5` through `100`. |

## Iteration 4 Readiness

| Task | Result |
|---|---|
| `T4.1` | Completed. `WorkController#index` is available through `GET /work`. |
| `T4.2` | Completed. The Haml work view uses `select_tag` to select a theme and submit it as `theme_id`. |
| `T4.3` | Completed. The selected theme's first image title, file, and average value are displayed through Rails helpers. |
| `T4.4` | Completed. Rating UI is prepared with `image_id` and a constrained numeric field; the submit button is intentionally disabled until authentication and rating persistence are added. |

## Iteration 5 Readiness

| Task | Result |
|---|---|
| `T5.1` | Completed. API routes exist at `GET /api/next_image` and `GET /api/prev_image`. |
| `T5.2` | Completed. `next_image` returns JSON for the next image in a theme. |
| `T5.3` | Completed. `prev_image` returns JSON for the previous image in a theme. |
| `T5.4` | Completed. The work page loads local jQuery plus `work.js`; next/previous buttons update image data through AJAX. |
| `T5.5` | Completed. API tests cover cyclic wrapping at the first and last image. |

## Lab Reuse Map

| Lab | Expected artifacts | Related tasks | Current status |
|---|---|---|---|
| Lab 1 | Rails project, Git setup, PostgreSQL config | T1.1-T1.4 | Full lab project not found. Use `labs/*.txt` snippets plus fresh implementation. |
| Lab 2 | `MainController`, layout, Haml/Sass, Bootstrap | T2.1-T2.5 | Full lab project not found. Use `labs/*.txt` snippets plus fresh implementation. |
| Lab 3-4 | Models, migrations, associations, seeds | T3.1-T3.7 | Implemented from `labs/*.txt` snippets plus fresh Rails migrations/models/seeds. |
| Lab 5-6 | `WorkController`, API/AJAX image switching | T4.1-T5.5 | Work area baseline and jQuery AJAX image navigation implemented from snippets plus fresh Rails code. |
| Lab 7 | Registration, sessions, Gravatar | T6.1-T6.7 | Full lab project not found. Use `labs/*.txt` snippets plus fresh implementation. |
| Lab 8 | I18n `ru.yml` and `en.yml`, locale switcher | T7.1-T7.4 | Full lab project not found. Use `labs/*.txt` snippets plus fresh implementation. |
| Lab 9 | Deployment config and production notes | T10.1-T10.4 | Full lab project not found. Use `labs/*.txt` snippets plus fresh implementation. |
| Lab 10 | RuboCop, Brakeman, SimpleCov setup | T9.1-T9.6 | Full lab project not found. Use `labs/*.txt` snippets plus fresh implementation. |
