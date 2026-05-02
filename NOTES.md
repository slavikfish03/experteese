# Planning Notes

## Assumptions

- The repository root is `D:\RUBY_PROJECT`.
- The only project plan source available locally is `ruby_project_plan.txt`.
- A Rails 8.1.x application is present in the repository root and is being extended iteration by iteration.
- Full laboratory project source code is not present, but lab reference snippets are available under `D:\RUBY_PROJECT\labs`.
- Future implementation should avoid destructive database, Docker, Git, and filesystem commands unless the user explicitly approves them.

## Iteration 0 Decisions

| Task | Decision |
|---|---|
| `T0.1` | Generate or integrate the Rails app directly in `D:\RUBY_PROJECT`. |
| `T0.2` | Reuse `D:\RUBY_PROJECT\labs` as reference material only; it is not complete project code. |
| `T0.3` | Target deployment platform: `Railway`. |
| `T0.4` | Use local repository images in `assets/images/pictures`; register the path in `config/initializers/assets.rb`; store only filenames in `db/seeds.rb`; render via `image_tag`. |

## Iteration 1 Findings

| Task | Finding |
|---|---|
| `T1.1` | Rails application skeleton is generated directly in `D:\RUBY_PROJECT`. |
| `T1.2` | `ruby --version` is `3.4.8`; after dependency resolution the project runs on Rails `8.1.3`. |
| `T1.3` | Git is initialized in `D:\RUBY_PROJECT` and `.gitignore` is configured. |
| `T1.4` | PostgreSQL 18.3 connectivity is verified through `D:\Program Files\PostgreSQL\18\bin\psql.exe`; `experteese_development` and `experteese_test` were created successfully. |

## Iteration 1 Planning Notes

- Rails `8.1.x` is explicitly accepted for this project. The generated app resolved to `8.1.3`.
- The lab snippet for `config/secrets.yml` should not be copied directly into a modern Rails 7/8 app. For implementation, use Rails credentials or environment variables for database passwords and `secret_key_base`.
- The lab snippet confirms the structural direction for `config/database.yml`: PostgreSQL adapter, separate `development`/`test`/`production` sections, and externalized secrets.
- Git initialization was performed after generating the Rails skeleton, and `.gitignore` was added manually because the project was generated with `--skip-git`.

## Iteration 2 Findings

| Task | Finding |
|---|---|
| `T2.1` | `MainController` was added with `index`, `help`, `about`, and `contacts` actions; routes now expose `/`, `/help`, `/about`, and `/contacts`. |
| `T2.2` | The ERB layout was replaced with `app/views/layouts/application.html.haml`. |
| `T2.3` | Shared partials `app/views/shared/_header.html.haml` and `app/views/shared/_footer.html.haml` now frame the static pages. |
| `T2.4` | `haml-rails`, `dartsass-rails`, `bootstrap`, and `font-awesome-sass` were added; `app/assets/stylesheets/application.scss` builds successfully through `rails dartsass:build`. |
| `T2.5` | The header includes working navigation links for current static pages and non-clickable placeholders for future Work/Login/Profile areas. |

## Iteration 2 Planning Notes

- The Bootstrap navbar was implemented without the collapse/toggler JavaScript dependency to keep the asset setup minimal at this stage.
- `bin/dev` was adjusted to fall back to `rails server` plus a one-off Dart Sass build when `foreman` is not installed locally.
- Static page rendering was verified through `ActionDispatch::Integration::Session` requests with the local PostgreSQL password supplied via `POSTGRES_PASSWORD`.
- Sass compilation currently emits upstream deprecation warnings from Bootstrap 5.3 and optional `VIPS-WARNING` messages from `image_processing`; neither blocks Iteration 2.

## Iteration 3 Findings

| Task | Finding |
|---|---|
| `T3.1` | `User` now has `name`, `email`, `password_digest`, and `remember_token`; email/name DB indexes are unique, and `has_secure_password` is enabled through `bcrypt`. |
| `T3.2` | `Theme` stores a unique `name` and has a `has_many :images` association. |
| `T3.3` | `Image` stores `name`, unique `file`, `theme_id`, and integer `ave_value`, defaulting to `0`. |
| `T3.4` | `Value` stores `user_id`, `image_id`, and integer `value`, with a unique pair index on `user_id`/`image_id`. |
| `T3.5` | Associations, validations, and lab-inspired helper scopes/methods are defined in the models. |
| `T3.6` | Seed data is idempotent and uses local JPEG files under `assets/images/pictures`, registered in `config/initializers/assets.rb`. |
| `T3.7` | `Value#value` accepts only integer ratings in the `5..100` range. |

## Iteration 3 Planning Notes

- The lab seed snippet uses `delete_all` and primary-key resets; the implementation avoids those destructive operations and uses idempotent upserts instead.
- Seed data currently creates 4 themes including the default placeholder theme, 12 images across 3 evaluation themes, and one sample user.
- `Image#ave_value` is recalculated by an `after_create` callback on `Value`, matching the earlier clarification that averages update immediately after a new rating.
- `has_secure_password` was implemented during Iteration 3 because seed user creation and `password_digest` validation depend on it; the later authentication iteration can reuse this foundation.
- A verification rating was created in the development database to prove average recalculation. It is not part of `db/seeds.rb`.

## Iteration 4 Findings

| Task | Finding |
|---|---|
| `T4.1` | `WorkController#index` and `GET /work` are implemented. |
| `T4.2` | The work view uses `select_tag :theme_id` and a GET form to choose a theme without adding AJAX ahead of Iteration 5. |
| `T4.3` | The controller loads themes with images, selects a requested or first available theme, and displays the first image using `image_tag image.file`. |
| `T4.4` | The rating UI includes hidden `image_id` and a numeric `value` field constrained to `5..100`; submit is disabled until authentication and rating persistence exist. |

## Iteration 4 Planning Notes

- The lab snippet depends on `current_user`, AJAX endpoints, and jQuery. Those are intentionally deferred to Iterations 5 and 6.
- The default seed placeholder theme is not listed on `/work` unless it has images, because the work area needs a real image to display.
- `test/controllers/work_controller_test.rb` covers rendering the selector, selected image, and rating input structure.
- Test image fixtures now reference real repository JPEG filenames so asset lookup succeeds during view rendering.

## Iteration 5 Findings

| Task | Finding |
|---|---|
| `T5.1` | `Api::ApiController` is implemented under `app/controllers/api`, with routes for `next_image` and `prev_image`. |
| `T5.2` | The next-image endpoint returns selected image metadata, average value, total ratings count, and a Propshaft-resolved `image_url`. |
| `T5.3` | The previous-image endpoint uses the same payload and wraps cyclically. |
| `T5.4` | `app/assets/javascripts/jquery.js` is stored locally, and `app/assets/javascripts/work.js` uses `$.ajax` to update the work area without a page reload. |
| `T5.5` | Tests verify next, previous, wraparound, and missing-theme JSON behavior. |

## Iteration 5 Planning Notes

- The API currently reports `user_valued: false` and `value: 0` because authentication/current-user behavior is not implemented yet.
- The JSON payload includes `image_url` instead of forcing JavaScript to guess the asset path; this keeps fingerprinted Propshaft assets working in development and production.
- The work page loads jQuery only for the work area through `content_for :head`, avoiding a global JavaScript dependency for static pages.
- The local dev server at `3001` was started before `jquery.js` existed and does not see the new asset path; the current verified server is on `3002`.

## Risks and Warnings

| Risk | Why it matters | Prevention |
|---|---|---|
| Missing lab artifacts | The course plan expects reuse of lab work at each stage, but no lab files are visible. | Ask for the relevant lab code before each implementation iteration or document that the step is recreated from scratch. |
| Unclear Rails app location | Generating Rails files in the wrong directory can create noisy structure or force later moves. | Confirm root vs nested app directory before `rails new`. |
| Rating scale drift | `Value#value`, forms, validations, and average calculations must all use the same scale. | Keep `5..100` as the single source constraint and mirror it in future forms. |
| `Image#ave_value` consistency | Stored averages can become stale if future update/delete rating flows bypass the create callback. | Route future rating mutations through model methods/callbacks or add recalculation on update/delete when those flows exist. |
| AJAX boundary behavior | First/last image navigation can produce confusing API behavior if undefined. | Clarify whether navigation wraps, disables buttons, or returns the same image. |
| Authentication order | Work area and rating submission depend on current user logic. | Keep the rating form non-persistent until sessions/current user are implemented, then protect submission server-side. |
| Overusing direct SQL | Course theory emphasizes Active Record and MVC. | Prefer associations, scopes, and query interfaces unless SQL is clearly justified. |
| Logic leaking into views | Haml templates can become overloaded with selection/statistics logic. | Keep nontrivial queries in controllers, models, scopes, or small service/query objects. |
| Locale hardcoding | Static Russian/English strings in views make I18n incomplete. | Use translation keys for navigation, auth forms, work area labels, and profile text. |
| Asset setup mismatch | Rails 7 can use import maps, asset pipeline, or bundling; jQuery/Bootstrap setup must match the generated app. | Inspect generated app before choosing the integration method. |
| Optional tests becoming too late | Adding tests only after all features makes regressions harder to isolate. | Add focused model/request tests when each stable domain area appears, even if full RSpec setup is optional. |
| Deployment platform differences | Railway and Heroku need different config conventions. | Choose platform before writing deployment artifacts. |
| Production data safety | Migrations/seeds can modify persistent data. | Review production commands explicitly before running them and avoid destructive reset/seed patterns. |

## Open Questions for User

Iteration 5 has no remaining open questions.


## Answer

| ID | Question | Answer | 
| --- | --- | --- | --- |
| **B1** | Where should the Rails app live: repository root or nested directory? | The Git repository should be initialized directly in the root directory of the project (the application's file tree). |
| **B2** | Are lab source files available, and if so where? |All the code available from the lab assignments is located in the /labs folder. IMPORTANT: this is not the project code and not the lab assignment code; these are some code snippets that I managed to obtain.| 
| **B3** | What is the rating scale for `Value#value`? |The grade is assigned on a scale from 5% to 100% (the models use integers, for example, 40 or 85). |
| **B4** | How should image navigation behave at first/last image? |Cyclic scrolling has been implemented: when reaching the last image, navigating forward loops back to the first (index 0), and when navigating backward from the first, it jumps to the last.|
| **B5** | How and when should `Image#ave_value` be recalculated? | The average value must be recalculated immediately after a new rating (Value) is created for the given image. |
| **B6** | Should tests use RSpec or the default Rails test framework? |The course recommends using RSpec, as it is considered a more concise and descriptive tool. |
| **B7** | Should deployment target Railway or Heroku? | The target platform is Railway, since Heroku has discontinued its free tier plans. |
| **B8** | What image storage strategy should be used for seed images: remote URLs, local assets, or uploaded files? | Use local files stored in `assets/images/pictures`; add that path in `config/initializers/assets.rb`; in `db/seeds.rb`, save only the filename; display through `image_tag`. |

## Non-Goals for This Planning Pass

- Future iterations beyond AJAX image navigation are not implemented yet.
- No full authentication flow, rating persistence, localization, profile statistics, or deployment steps are implemented in this pass.
- No dedicated test suite, linter, or security scan has been added yet.
- No destructive commands are executed.
