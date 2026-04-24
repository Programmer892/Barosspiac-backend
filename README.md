# Baross Piac

## A projektről

> Ez egy webes platform, ahol a diákok könnyedén adhatnak és vehetnek különféle termékeket, mint például ruhákat, könyveket, tanszereket és más tárgyakat. A cél, hogy az iskolai közösség tagjai közötti cserét és vásárlást egyszerűvé és biztonságossá tegyük, támogatva a fenntarthatóságot és az együttműködést.

---

## Készítette
- Szabó Előd, Szűcs M. Sándor *(Backend, MySQL adatbázis)*
- [GitHub repo](https://github.com/Programmer892/Barosspiac-backend)

---

## Fejlesztési környezet

### Backend
- Node.js
- Express.js (REST API)
- Socket.IO (valós idejű kommunikáció)
- JWT (autentikáció)
- bcryptjs (jelszó titkosítás)
- dotenv (környezeti változók)
- cors (CORS kezelés)

### Adatbázis
- MySQL
- mysql2 (Node.js driver)

### Fájlkezelés
- Multer (file upload)
- Cloudinary (képtárolás)

### Email
- Nodemailer (email küldés)

### Fejlesztői eszközök
- Nodemon 
- Postman 
---

## Adatbázis

- conversations
  - conversations_id
  - user1_id
  - user2_id
  - created_at

- likes
  - user_id
  - product_id
  - date
  - is_liked

- main_categories
  - category_id
  - category_name

- messages
  - message_id
  - conversations_id
  - sender_id
  - message
  - sent_at
  - message_state
  - read_at

- product
  - product_id
  - user_id
  - version
  - product_title
  - product_desc
  - product_price
  - product_condition
  - product_collpoint
  - product_size
  - product_subject
  - product_class
  - category_id
  - sub_category_id
  - sub_sub_category_id
  - is_sold
  - product_upload
  - status

- productimg
  - img_id
  - product_id
  - product_img

- ratings
  - rating_id
  - rater_id (Értékelő)
  - rated_id (Értékelt)
  - rate
  - text
  - created_at

- reports
  - report_id
  - reporter_id
  - reported_id (Jelentett user)
  - product_id (Jelentett termék)
  - text
  - sending_date
  - reason
  - status

- subsubcategory
  - sub_sub_category_id
  - sub_category_id
  - sub_sub_name

- sub_category
  - sub_category_id
  - category_id
  - sub_category_name

- users
  - user_id
  - pfp
  - email
  - password_hash
  - fullname
  - userClass
  - role
  - verified
  - created_at
  - notify_message
  - notify_rating
  - notify_sold

![Adatbázis kapcsolatok](https://snipboard.io/FreViX.jpg)
DrawSql link (https://drawsql.app/teams/elod/diagrams/barosspiac)

---

## Backend

A backend Node.js alapú, Express keretrendszerrel és MySQL adatbázissal működik. Feladata a frontend és az adatbázis közötti kommunikáció biztosítása.

---

### Telepítés és futtatás

```bash
git clone https://github.com/Programmer892/Barosspiac-backend.git
npm install
npm run dev
```

---

### Mappa struktúra

```text
Backend/
├── config/
│   ├── cloudinary.js
│   └── db.js
├── controllers/
│   ├── categoryController.js
│   ├── conversationController.js
│   ├── likeController.js
│   ├── messagesController.js
│   ├── notificationController.js
│   ├── productController.js
│   ├── ratingsController.js
│   ├── reportController.js
│   ├── statisticController.js
│   └── userController.js
├── middleware/
│   ├── adminMiddleware.js
│   └── authMiddleware.js
├── routes/
│   ├── categoryRoute.js
│   ├── conversationRoute.js
│   ├── likeRoute.js
│   ├── messagesRoute.js
│   ├── notificationRoute.js
│   ├── productRoute.js
│   ├── ratingsRoute.js
│   ├── reportRoute.js
│   ├── statisticRoute.js
│   └── userRoute.js
├── utils/
│   └── notifications.js
├── package.json
├── package-lock.json
├── server.js
└── barosspiac3.sql
```

---

## Használt package-ek

```javascript
"dependencies": {
  "bcryptjs": "^3.0.3",
  "cloudinary": "^2.9.0",
  "cors": "^2.8.6",
  "dotenv": "^17.3.1",
  "express": "^5.2.1",
  "express-rate-limiter": "^1.3.1",
  "jsonwebtoken": "^9.0.3",
  "multer": "^2.1.1",
  "mysql2": "^3.17.2",
  "nodemailer": "^8.0.5",
  "socket.io": "^4.8.3",
  "ws": "^8.19.0"
}
```

---

## Biztonság

- JWT token alapú hitelesítés
- Jelszavak bcryptjs-sel hash-elve
- Middleware alapú auth ellenőrzés
- Környezeti változók `.env` fájlban

---

## Backend API használat

```javascript
app.use("/api/user", userRoute)
app.use("/api/product", productRoute)
app.use("/api/category", categoryRoute)
app.use("/api/ratings", ratingsRoute)
app.use("/api/likes", likeRoute)
app.use("/api/reports", reportRoute)
app.use("/api/conversations", conversationRoute)
app.use("/api/messages", messagesRoute)
app.use("/api/statistics", statisticRoute)
app.use("/api/notifications", notificationRoute)
```

---

# 1. userRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Regisztráció | `/register` | Új felhasználói fiók létrehozása emaillel és jelszóval |
| Bejelentkezés | `/login` | Felhasználó hitelesítése és token generálása |
| Kijelentkezés | `/logout` | Felhasználói munkamenet lezárása *(auth szükséges)* |
| Saját profil | `/me` | A jelenleg bejelentkezett felhasználó adatainak lekérdezése |
| Profil frissítés | `/user` | Név, email vagy egyéb profiladatok frissítése |
| Fiók törlése | `/delete` | A felhasználói fiók végleges törlése |
| Jelszó módosítás | `/password` | A felhasználó jelszavának frissítése |
| Értesítések beállítása | `/notification` | Értesítési preferenciák módosítása |
| Profilkép feltöltés | `/profile_pic` | Új profilkép feltöltése |
| Profilkép törlése | `/profile_pic` | Jelenlegi profilkép törlése |
| Összes felhasználó | `/alluser` | Minden felhasználó listázása |
| Felhasználó statisztika | `/statistic/:user_id` | Egy adott felhasználó teljes aktivitásának lekérdezése |
| Általános statisztika | `/statistics` | Rendszerszintű összesített statisztikák |

```javascript
router.post("/register", userRegister)
router.post("/login", userLogin)
router.post("/logout", auth, logout)
router.get("/me", auth, getUser)
router.post("/user", auth, updateUser)
router.delete("/delete", auth, userDelete)
router.put("/password", auth, updatePassword)
router.put("/notification", auth, updateNotifications)
router.post("/profile_pic", auth, upload.single("profilePic"), updatePfp)
router.delete("/profile_pic", auth, deletePfp)
router.get("/alluser", auth, getAllUser)
router.get("/statistic/:user_id", auth, userallInformation)
router.get("/statistics", auth, getStatistics)
```

# 2. productRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Legújabb termékek | `/latestProduct` | A legutóbb feltöltött termékek lekérdezése |
| Termék keresés | `/getProduct` | Szűrt termékek lekérdezése |
| Összes termék | `/allproduct` | Minden termék lekérdezése |
| Új termék | `/postProduct` | Új termék feltöltése maximum 5 képpel |
| Termék törlése | `/:product_id` | Adott termék törlése |
| Termék frissítése | `/update` | Termék adatainak módosítása |
| Termék lekérdezése | `/:product_id` | Egy adott termék lekérdezése ID alapján |
| Hasonló termékek | `/similar/:sub_category_id/:product_id` | Azonos alkategóriájú hasonló termékek |
| Aktív termékek | `/active_product/:user_id` | Felhasználó aktív hirdetései |
| Eladott termékek | `/sold_product/:user_id` | Felhasználó eladott termékei |
| Eladottnak jelölés | `/sold/:product_id` | Termék státuszának módosítása eladottra |

```javascript
router.get("/latestProduct", auth, getProduct)
router.get("/getProduct", auth, getProduct2)
router.get("/allproduct", auth, getAllProduct)
router.post("/postProduct", auth, upload.array("images", 5), postProduct)
router.delete("/:product_id", auth, deleteProduct)
router.put("/update", auth, upload.array("images", 5), updateProduct)
router.get("/:product_id", auth, getProductbyid)
router.get("/similar/:sub_category_id/:product_id", auth, getSimilarProduct)
router.get("/active_product/:user_id", auth, getByuserProduct)
router.get("/sold_product/:user_id", auth, getByuserSoldProduct)
router.put("/sold/:product_id", auth, markAsSold)
```

# 3. notificationRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Értesítések listája | `/notifications` | Felhasználó összes értesítése |
| Egy olvasása | `/read/:notification_id` | Egy értesítés olvasottnak jelölése |
| Összes olvasása | `/read-all` | Minden értesítés olvasottnak jelölése |
| Értesítés törlése | `/delete/:notification_id` | Egy értesítés törlése |

```javascript
router.get("/notifications", auth, getNotifications)
router.put("/read/:notification_id", auth, markNotificationAsRead)
router.put("/read-all", auth, markAllNotificationsAsRead)
router.delete("/delete/:notification_id", auth, deleteNotification)
```

# 4. messageRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Üzenetek | `/message/:conversations_id` | Beszélgetés üzenet |
| Olvasatlanok | `/unreaded` | Még nem olvasott üzenetek |
| Olvasottnak jelölés | `/read/:conversations_id` | Beszélgetési üzenetek olvasottnak jelölése |

```javascript
router.get("/message/:conversations_id", auth, getMessages)
router.get("/unreaded", auth, getUnreadedMessages)
router.put("/read/:conversations_id", auth, markMessagesAsRead)
```

# 5. likeRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Kedvelések | `/liked/:product_id` | Egy termék kedveléseinek száma |
| Kedvelés | `/like` | Termék kedvelése |
| Kedvelés visszavonása | `/unlike/:product_id` | Kedvelés eltávolítása |
| Összes törlése | `/alllike` | Minden like törlése |
| Összes kedvelt | `/alllikes` | Felhasználó összes kedvelt terméke |

```javascript
router.get("/liked/:product_id", auth, getLikes)
router.post("/like", auth, postLikes)
router.delete("/unlike/:product_id", auth, deleteLike)
router.delete("/alllike", auth, deleteAllLike)
router.get("/alllikes", auth, getallLikes)
```

# 6. conversationRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Beszélgetések | `/conversations` | Összes beszélgetés lekérdezése |
| Új beszélgetés | `/conversation` | Új beszélgetés létrehozása |

```javascript
router.get("/conversations", auth, getConversation)
router.post("/conversation", auth, postConversation)
```

# 7. categoryRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Kategóriák | `/getCategory` | Az összes kategória lekérdezése |

```javascript
router.get("/getCategory", getCategory)
```

# 8. reportRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Jelentés | `/report` | Felhasználó vagy termék jelentése |

```javascript
router.post("/report", auth, postReport)
```

# 9. ratingRoutes végpontok

| Művelet | Végpont | Leírás |
|----------|----------|----------|
| Új értékelés | `/postRatings` | Értékelés hozzáadása |
| Értékelés lekérdezése | `/:rated_id` | Egy értékelés lekérdezése |
| Felhasználó értékelései | `/ratings/:rated_id` | Összes értékelés lekérdezése |
| Értékelés törlése | `/rating/:rating_id` | Értékelés törlése |
| Értékelés frissítése | `/updaterating/:rating_id` | Értékelés módosítása |

```javascript
router.post("/postRatings", auth, postRatings)
router.get("/:rated_id", getRatingsById)
router.get("/ratings/:rated_id", getRatingsByUser)
router.delete("/rating/:rating_id", auth, deleteRating)
router.put("/updaterating/:rating_id", auth, updateRating)
```

---

---

## Frontend

- [GitHub repo](https://github.com/s4nyi324145/barosspiac)
- [Netlify](https://barosspiac.netlify.app)

---

## Használt eszközök

- Visual Studio Code
- Node.js / NPM
- Postman
- DrawSQL
- GitHub
- Google Drive
- PhpMyAdmin
- ChatGPT
