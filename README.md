# Experiment 7 — Spring Boot RBAC Demo

This project demonstrates role-based authorization (RBAC) using Spring Boot, Spring Security, and H2 database.

## Quick notes

- Start the app: `mvn spring-boot:run`
- H2 console: `http://localhost:8080/h2-console` (JDBC URL: `jdbc:h2:mem:exp7db`)
- Demo users are created at startup:
  - user1 / user123 (ROLE_USER)
  - admin1 / admin123 (ROLE_ADMIN)

## Endpoints

- GET `/api/public/hello` — public
- GET `/api/user/profile` — USER or ADMIN (requires HTTP Basic)
- GET `/api/admin/dashboard` — ADMIN only (requires HTTP Basic)

## Postman testing checklist

1. Access public endpoint: no auth, `GET /api/public/hello` → 200  
2. USER auth (`user1`): `GET /api/user/profile` → 200  
3. USER auth (`user1`): `GET /api/admin/dashboard` → 403 Forbidden  
4. ADMIN auth (`admin1`): `GET /api/admin/dashboard` → 200  
5. No auth on `/api/user/profile` → 401 Unauthorized  

## Screenshots

Place screenshots in the `screenshots/` folder as per the experiment instructions.