-- =============================================================================
-- ShopNest – Database Seed
-- Runs automatically on first container start via Docker Compose.
-- Safe to re-run: uses INSERT IGNORE to avoid duplicates.
-- =============================================================================

USE ecommerce;

-- ── Create Tables ─────────────────────────────────────────────────────────────

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  firstName VARCHAR(100) NOT NULL,
  lastName VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('customer', 'admin') DEFAULT 'customer',
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  imageUrl VARCHAR(500),
  isActive BOOLEAN DEFAULT 1,
  categoryId INT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE SET NULL
);

-- Cart table
CREATE TABLE IF NOT EXISTS carts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL UNIQUE,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

-- Cart items table
CREATE TABLE IF NOT EXISTS cart_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cartId INT NOT NULL,
  productId INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (cartId) REFERENCES carts(id) ON DELETE CASCADE,
  FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT,
  customerName VARCHAR(255) NOT NULL,
  customerEmail VARCHAR(255) NOT NULL,
  shippingAddress TEXT,
  total DECIMAL(10, 2) NOT NULL,
  status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (userId) REFERENCES users(id) ON DELETE SET NULL
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  orderId INT NOT NULL,
  productId INT NOT NULL,
  quantity INT NOT NULL,
  unitPrice DECIMAL(10, 2) NOT NULL,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE
);

-- ── Categories ────────────────────────────────────────────────────────────────
INSERT IGNORE INTO categories (id, name, description, createdAt, updatedAt) VALUES
  (1, 'Electronics',    'Gadgets, devices and tech accessories',  NOW(), NOW()),
  (2, 'Clothing',       'Apparel for men, women and kids',        NOW(), NOW()),
  (3, 'Home & Kitchen', 'Everything for your living space',       NOW(), NOW()),
  (4, 'Books',          'Fiction, non-fiction and educational',   NOW(), NOW()),
  (5, 'Sports',         'Equipment and activewear',               NOW(), NOW());

-- ── Products ─────────────────────────────────────────────────────────────────
INSERT IGNORE INTO products (id, name, description, price, stock, imageUrl, isActive, categoryId, createdAt, updatedAt) VALUES
  (1,  'Wireless Noise-Cancelling Headphones',
       'Premium over-ear headphones with 30-hour battery life and active noise cancellation.',
       129.99, 45,'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',1,1,NOW(), NOW()),

  (2,  'Mechanical Keyboard',
       'Compact TKL layout with Cherry MX switches, RGB backlight and USB-C connection.',
       89.99, 30,'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600',1,1,NOW(),NOW()),

  (3,  'Portable Bluetooth Speaker',
       'Waterproof, 360° sound, 12-hour playtime. Perfect for outdoor adventures.',
       59.99, 60,'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600', 1, 1, NOW(), NOW()),

  (4,  'USB-C Hub 7-in-1',
       'Expands your laptop with HDMI 4K, 3× USB-A, SD card reader, and 100W PD.',
       39.99, 80,'https://images.unsplash.com/photo-1625948515291-69fc34fe6d26?w=600', 1, 1, NOW(), NOW()),

  (5,  'Classic White Sneakers',
       'Minimalist leather sneakers with cushioned sole. Fits true to size.',
       74.99, 120,'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600', 1, 2, NOW(), NOW()),

  (6,  'Slim-Fit Denim Jacket',
       'Versatile mid-weight denim jacket. Available in washed blue.',
       69.99, 55,'https://images.unsplash.com/photo-1551537482-f2075a1d41f2?w=600', 1, 2, NOW(), NOW()),

  (7,  'Merino Wool Crew Neck Sweater',
       'Ultra-soft 100% merino wool. Lightweight yet warm for layering.',
       89.99, 40,'https://images.unsplash.com/photo-1599481238641-a0c339a3cbe8?w=600', 1, 2, NOW(), NOW()),

  (8,  'Ceramic Pour-Over Coffee Set',
       'Includes dripper, carafe and filters. Brews a clean, flavourful cup every time.',
       44.99, 35,'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600', 1, 3, NOW(), NOW()),

  (9,  'Bamboo Cutting Board Set',
       'Set of 3 eco-friendly bamboo boards with juice grooves and handles.',
       29.99, 70,'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600', 1, 3, NOW(), NOW()),

  (10, 'The Pragmatic Programmer',
       '20th Anniversary Edition. A must-read for every software developer.',
       49.99, 25,'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=600', 1, 4, NOW(), NOW()),

  (11, 'Atomic Habits',
       'An easy and proven way to build good habits and break bad ones by James Clear.',
       17.99, 90,'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=600', 1, 4, NOW(), NOW()),

  (12, 'Yoga Mat – 6mm Non-Slip',
       'Extra-thick, eco-friendly TPE mat with alignment lines and carry strap.',
       34.99, 65,'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=600', 1, 5, NOW(), NOW());

-- ── Admin user (password: Admin1234!) ─────────────────────────────────────────
-- bcrypt hash of "Admin1234!" with 10 rounds
INSERT IGNORE INTO users (id, email, firstName, lastName, password, role, createdAt, updatedAt) VALUES
  (1, 'admin@shopnest.com', 'Admin', 'User',
   '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.',
   'admin', NOW(), NOW());

-- ── Demo customer (password: Customer123!) ────────────────────────────────────
-- bcrypt hash of "Customer123!" with 10 rounds
INSERT IGNORE INTO users (id, email, firstName, lastName, password, role, createdAt, updatedAt) VALUES
  (2, 'customer@example.com', 'Jane', 'Doe',
   '$2b$10$TkVmGxnAI5aAFZ9N7XmN8.K/EVJhFJq3mLiG3VFDjUJ0mzFuLiYKy',
   'customer', NOW(), NOW());
