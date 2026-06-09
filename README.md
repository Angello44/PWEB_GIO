# EventHub - Event Management System

EventHub adalah aplikasi web untuk mengelola dan mengikuti berbagai event seperti seminar, workshop, conference, dan pelatihan. Sistem ini memungkinkan pengguna untuk melihat daftar event, melakukan registrasi akun, login, dan mendaftar ke event yang tersedia.

---

## Fitur Utama

### Pengguna
- Registrasi akun
- Login dan Logout
- Melihat daftar event
- Melihat detail event
- Mendaftar event
- Melihat event yang telah didaftarkan

### Admin
- Menambah event
- Mengubah data event
- Menghapus event
- Melihat daftar peserta event
- Mengelola data event

---

## Teknologi yang Digunakan

### Frontend
- HTML5
- CSS3
- JavaScript (Vanilla JS)

### Backend
- Node.js
- Express.js

### Database
- MySQL

---

## Struktur Folder

```bash
project-root/
│
├── backend/
│   ├── config/
│   │   └── db.js
│   │
│   ├── routes/
│   │   ├── eventRoutes.js
│   │   ├── userRoutes.js
│   │   └── registrationRoutes.js
│   │
│   ├── controllers/
│   │
│   ├── models/
│   │
│   ├── server.js
│   └── package.json
│
├── frontend/
│   ├── assets/
│   │
│   ├── css/
│   │   └── style.css
│   │
│   ├── js/
│   │   └── app.js
│   │
│   └── index.html
│
└── README.md
```

---

## Database

### Tabel Users

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255)
);
```

### Tabel Events

```sql
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    date DATE,
    location VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10,2)
);
```

### Tabel Registrations

```sql
CREATE TABLE registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_id INT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);
```

---

## Instalasi

### 1. Clone Repository

```bash
git clone https://github.com/username/eventhub.git
```

### 2. Masuk ke Folder Backend

```bash
cd backend
```

### 3. Install Dependency

```bash
npm install
```

### 4. Konfigurasi Database

Buat database MySQL:

```sql
CREATE DATABASE eventhub;
```

Kemudian sesuaikan konfigurasi database pada file:

```js
backend/config/db.js
```

Contoh:

```js
const mysql = require("mysql2");

const db = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "",
    database: "eventhub"
});

module.exports = db.promise();
```

### 5. Jalankan Server

```bash
node server.js
```

atau

```bash
npm start
```

Server berjalan pada:

```bash
http://localhost:5000
```

---

## API Endpoint

### Event

#### Mendapatkan Semua Event

```http
GET /api/events
```

#### Menambah Event

```http
POST /api/events
```

#### Mengubah Event

```http
PUT /api/events/:id
```

#### Menghapus Event

```http
DELETE /api/events/:id
```

---

### User

#### Register

```http
POST /api/users/register
```

#### Login

```http
POST /api/users/login
```

---

### Registrasi Event

#### Mendaftar Event

```http
POST /api/registrations
```

Body:

```json
{
  "userId": 1,
  "eventId": 3
}
```

---

## Alur Sistem

1. Pengguna membuat akun.
2. Pengguna login ke sistem.
3. Pengguna melihat daftar event.
4. Pengguna memilih event yang diinginkan.
5. Pengguna melakukan pendaftaran event.
6. Data pendaftaran disimpan ke database.
7. Pengguna dapat melihat event yang telah didaftarkan.

---

## Tampilan Sistem

### Halaman Home
Menampilkan event unggulan dan informasi platform.

### Halaman Jelajah Event
Menampilkan seluruh event yang tersedia.

### Halaman Login & Register
Digunakan untuk autentikasi pengguna.

### Halaman Event Saya
Menampilkan daftar event yang telah didaftarkan.

### Dashboard Admin
Digunakan untuk mengelola data event dan peserta.

---

## Pengembang

**Angello Giovanida Anthony**  
Universitas Pignatelli Triputra Surakarta

---

## Lisensi

Project ini dibuat untuk keperluan pembelajaran dan tugas akademik.
