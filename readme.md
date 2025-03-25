

# PostgreSQL FAQ

## 1. What is PostgreSQL?
PostgreSQL একটি উন্নত, ওপেন-সোর্স রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS).এটি  জটিল কোয়েরি, ইনডেক্সিং এবং বিভিন্ন ডেটা টাইপ সমর্থন করে।

## 2. What is the purpose of a database schema in PostgreSQL?
PostgreSQL-এ একটি ডেটাবেস স্কিমা হল একটি ডেটাবেসের মধ্যে একটি যৌক্তিক নেমস্পেস যা টেবিল, ভিউ, ইনডেক্স, ফাংশন এবং অন্যান্য ডেটাবেস অবজেক্ট ধারণ করে।একাধিক ব্যবহারকারীকে ডেটাবেসের বিভিন্ন অংশে কাজ করার সুযোগ দেয়।

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
- **Primary Key**: একটি primary key হল একটি কলাম বা কলামের সেট যা টেবিলের প্রতিটি সারিকে unique চিহ্নিত করে। এটি অনন্যতা নিশ্চিত করে এবং দ্রুত অনুসন্ধানের জন্য একটি ইনডেক্স স্বয়ংক্রিয়ভাবে তৈরি করে।
- **Foreign Key**: A foreign key হল একটি কলাম বা কলামের সেট যা দুটি টেবিলের মধ্যে সম্পর্ক স্থাপন করে। এটি অন্য একটি টেবিলের primary key রেফারেন্স করে এবং রেফারেন্সিয়াল ইন্টিগ্রিটি প্রয়োগ করে।

## 4. What is the difference between the VARCHAR and CHAR data types?
- **VARCHAR (Variable Character)**:  এটি একটি নির্ধারিত সর্বাধিক দৈর্ঘ্যের ভ্যারিয়েবল-দৈর্ঘ্যের string সংরক্ষণ করে।এটি প্রয়োজনীয় স্পেসই ব্যবহার করে
- **CHAR (Fixed Character)**:এটি স্থির দৈর্ঘ্যের String সংরক্ষণ করে, এবং ছোট মানগুলিকে space দ্বারা fullfil করে।

## 5. Explain the purpose of the WHERE clause in a SELECT statement.
`WHERE` ক্লজটি নির্দিষ্ট শর্তের উপর ভিত্তি করে রেকর্ড Filter করে।
**Example:**
```sql
SELECT * FROM users WHERE age > 18;
```

## 6. What are the LIMIT and OFFSET clauses used for?
- **LIMIT**: এটি একটি query দ্বারা ফেরত দেওয়া row সংখ্যা সীমাবদ্ধ করে।.
- **OFFSET**: এটি ফলাফল ফেরত দেওয়ার আগে একটি নির্দিষ্ট সংখ্যক সারি skip করে, সাধারণত Pagination এর জন্য ব্যবহৃত হয়
**Example:**
```sql
SELECT * FROM products ORDER BY id LIMIT 10 OFFSET 20;
```

## 7. How can you modify data using UPDATE statements?
 `UPDATE`স্টেটমেন্টটি একটি টেবিলের বিদ্যমান রেকর্ড সংশোধন করে। এটি একটি শর্তের উপর ভিত্তি করে একটি বা একাধিক কলাম আপডেট করতে দেয়।
**Example:**
```sql
UPDATE users SET email = 'newemail@example.com' WHERE id = 1;
```

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
 `JOIN` অপারেশনটি সম্পর্কিত কলামের উপর ভিত্তি করে একাধিক টেবিল থেকে row একত্রিত করে:
- **INNER JOIN**: দুটি টেবিলের মিলানো row ফেরত দেয় 
- **LEFT JOIN**: বাম টেবিলের সব সারি এবং ডান টেবিলের matching সারি ফেরত দেয়
- **RIGHT JOIN**: ডান টেবিলের সব সারি এবং বাম টেবিলের matching সারি ফেরত দেয়
- **FULL JOIN**: যখন একটি মিল থাকে তখন দুটি টেবিলের সব সারি ফেরত দেয়.
**Example:**
```sql
SELECT users.name, orders.amount
FROM users
INNER JOIN orders ON users.id = orders.user_id;
```

## 9. Explain the GROUP BY clause and its role in aggregation operations.
The `GROUP BY` GROUP BY ক্লজটি নির্দিষ্ট কলামগুলিতে একসাথে সমান মান সহ সারি গোষ্ঠীভুক্ত করে এবং অ্যাগ্রিগেট ফাংশন যেমন  `COUNT()`, `SUM()`, or `AVG()`. প্রয়োগ করে ।
**Example:**
```sql
SELECT category, COUNT(*) FROM products GROUP BY category;
```

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
Aggregate functions perform calculations on a set of rows and return a single value.
- **COUNT()**: সারির সংখ্যা গণনা করে।
- **SUM()**:সংখ্যাত্মক কলাম মান যোগ করে।
- **AVG()**: গড় মান গণনা করে
**Example:**
```sql
SELECT COUNT(*) FROM orders;
SELECT SUM(amount) FROM payments;
SELECT AVG(price) FROM products;
```
