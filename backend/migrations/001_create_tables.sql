-- Users Table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255),
  role VARCHAR(50)
);

-- Groups Table
CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT
);

-- Group Members
CREATE TABLE group_members (
  group_id INTEGER NOT NULL REFERENCES groups(id),
  user_id INTEGER NOT NULL REFERENCES users(id),
  joined_at TIMESTAMP,
  PRIMARY KEY (group_id, user_id)
);

-- Events
CREATE TABLE events (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  type VARCHAR(20),
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  location VARCHAR(255)
);

-- Event Attendance
CREATE TABLE event_attendance (
  event_id INTEGER NOT NULL REFERENCES events(id),
  user_id INTEGER NOT NULL REFERENCES users(id),
  rsvp_status VARCHAR(20),
  PRIMARY KEY (event_id, user_id)
);

-- Setlists
CREATE TABLE setlists (
  id SERIAL PRIMARY KEY,
  event_id INTEGER REFERENCES events(id),
  created_by INTEGER REFERENCES users(id),
  created_at TIMESTAMP
);

-- Setlist Songs
CREATE TABLE setlist_songs (
  setlist_id INTEGER REFERENCES setlists(id),
  title VARCHAR(255),
  "order" INTEGER,
  notes TEXT,
  PRIMARY KEY (setlist_id, "order")
);

-- Messages
CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  sender_id INTEGER REFERENCES users(id),
  text TEXT,
  sent_at TIMESTAMP
);

-- Files
CREATE TABLE files (
  id SERIAL PRIMARY KEY,
  event_id INTEGER REFERENCES events(id),
  url TEXT,
  uploaded_by INTEGER REFERENCES users(id),
  uploaded_at TIMESTAMP
);
