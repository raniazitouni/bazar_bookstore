# BAZAR BookStore App

---

## Project Structure

```bash
lib/
│
├── core/                # Shared utilities, themes, widgets
├── features/
│   ├── auth/            # Authentication (sign in, sign up, profile )
│   ├── books/           # home , Book list, details , search
│   ├── authors/         # Author list
│   ├── vendors/         # Vendor list
│   └──wishlist/        # Wishlist screen
└── main.dart
```

---

## Database shema

- **users**

  - id, name, email, phone_number, picture_url

- **books**

  - id, title, cover_url, description, book_category, author_id, vendor_id, price

- **author**

  - id, fullname, author_category, picture_url, about

- **vendors**

  - id, title, logo_url, vendor_category

- **wishlists**

  - book_id, user_id

- **reviews**
  - id, user_id, target_id, target_type (enum: book, author, vendor), rating (1–5)

---

## Features

- **Authentication**

  - Sign In / Sign Up
  - Forget Password
  - Persistent login with Supabase Auth session

- **Home Page**

  - Horizontal carousels for **Books, Authors, Vendors**
  - "See All" pages with category filters

- **Book Details**

  - Book cover, description, price
  - Star reviews
  - Add to Wishlist

- **Wishlist**

  - Save books to wishlist
  - Remove by unliking
  - Persistent across sessions

- **Profile**
  - User info
  - Logout button

---
