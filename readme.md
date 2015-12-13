# <img src="https://cloud.githubusercontent.com/assets/7833470/10899314/63829980-8188-11e5-8cdd-4ded5bcb6e36.png" height="60"> Rails Blog App

**Objective:** Use Rails to build a full-stack blog application. You will be building this app over the course of three evenings.

**Your objective for this evening is to set up the `users` resource of your blog, and implement authentication, validations, and error-handling.**

## Getting Started

1. Fork this repo, and clone it into your `develop` folder on your local machine.
2. Change directories into `rails_blog_app`, and run `rake db:create` from the Terminal.
3. Start your Rails server, then you're ready to go!

## Minimum Requirements

* RESTful routes for the `users` resource. Your app should have the following routes:
  * `GET /users`
  * `GET /users/new` (or `GET /signup`)
  * `POST /users`
  * `GET /users/:id`
  * `GET /users/:id/edit`
  * `PUT /users/:id` and/or `PATCH /users/:id` (Rails `resources` generates both)
  * `DELETE /users/:id`
* Controller actions for each of your RESTful routes that implement CRUD for `users` (for now, you can let any user update or delete another user in the database).
* A `User` model and corresponding database table with the minimum attributes `email` and `password_digest`.
* Model validations on `User`:
  * `email`: presence, uniqueness, validates format
  * `password`: presence, minimum 6 characters
* Error-handling in the `UsersController` that redirects the user if they submit invalid form data and shows a flash message with the error.
* The ability for users to sign up with a secure password and log back into your site. You will need the following routes for authentication in addition to the RESTful routes listed above:
  * `GET /login`
  * `POST /login` or `POST /sessions`
  * `GET /logout`

**If you get stuck at any point or need extra guidance, feel free to look at the [solution branch](https://github.com/sf-wdi-24/rails_blog_app/tree/solution) or follow along with the <a href="https://www.railstutorial.org/book" target="_blank">*Ruby on Rails Tutorial* by Michael Hartl</a>.**

## Bonus

* *Authorize* your site by only letting users update and delete their own accounts. **Hints:**
  * You'll need to check for the `current_user` in the view to determine whether or not to show the edit and delete buttons. You'll also need to check for the `current_user` in any controller method you want to authorize.
  * If `current_user` is the same `@user` found by the `id` in the URL params, the user is authorized to update and delete.
* Another step to authorization is making sure the `current_user` cannot sign up or log in again. Use the `current_user` method in your controllers to authorize those routes as well.

Refer to the [solution_authorization branch](https://github.com/sf-wdi-24/rails_blog_app/tree/solution_authorization) for guidance.

## Submission

* As you make code changes, frequently commit and push to GitHub.
* Once you've finished the assignment and pushed your work to GitHub, make a pull request from your fork to the original repo.
