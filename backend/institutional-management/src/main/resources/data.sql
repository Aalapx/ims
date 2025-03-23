-- Delete existing data in correct order to maintain referential integrity
DELETE FROM transport_bookings;
DELETE FROM transport_routes;
DELETE FROM order_items;
DELETE FROM food_orders;
DELETE FROM food_items;
DELETE FROM room_bookings;
DELETE FROM rooms;
DELETE FROM hall_bookings;
DELETE FROM hall_amenities;
DELETE FROM halls;
DELETE FROM users WHERE email = 'test@example.com';

-- Insert admin user
INSERT INTO users (name, email, password, role) VALUES 
('Admin User', 'test@example.com', '$2a$10$slYQmyNdGzTn7ZLBXBChFOC9f6kFjAqPhccnP6DxlWXx2lPk1C3G6', 'ADMIN');

-- Insert sample halls
INSERT INTO halls (name, description, capacity, price_per_hour, image_url, is_available) VALUES
('Grand Ballroom', 'Elegant hall for large events', 500, 1000.00, 'https://images.pexels.com/photos/260928/pexels-photo-260928.jpeg', true),
('Conference Room A', 'Professional meeting space', 50, 200.00, 'https://images.pexels.com/photos/1181406/pexels-photo-1181406.jpeg', true),
('Seminar Hall', 'Perfect for workshops', 100, 300.00, 'https://images.pexels.com/photos/1181354/pexels-photo-1181354.jpeg', true);

-- Insert hall amenities
INSERT INTO hall_amenities (hall_id, amenity) VALUES
(1, 'Stage'),
(1, 'Sound System'),
(1, 'Projector'),
(1, 'Catering Service'),
(2, 'Projector'),
(2, 'Whiteboard'),
(2, 'Video Conferencing'),
(3, 'Sound System'),
(3, 'Projector'),
(3, 'Podium');

-- Insert sample rooms
INSERT INTO rooms (room_number, room_type, capacity, price_per_night, is_available) VALUES
('101', 'SINGLE', 1, 100.00, true),
('102', 'DOUBLE', 2, 150.00, true),
('201', 'SUITE', 3, 250.00, true),
('202', 'FAMILY', 4, 300.00, true);

-- Insert sample food items
INSERT INTO food_items (name, description, price, category, is_available, image_url) VALUES
('Chicken Burger', 'Juicy chicken patty with fresh vegetables', 8.99, 'FAST_FOOD', true, 'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg'),
('Vegetable Pizza', 'Fresh vegetables on crispy base', 12.99, 'PIZZA', true, 'https://images.pexels.com/photos/1146760/pexels-photo-1146760.jpeg'),
('Caesar Salad', 'Fresh romaine lettuce with classic dressing', 6.99, 'SALAD', true, 'https://images.pexels.com/photos/1059905/pexels-photo-1059905.jpeg'),
('Chocolate Brownie', 'Rich chocolate brownie with nuts', 4.99, 'DESSERT', true, 'https://images.pexels.com/photos/2067396/pexels-photo-2067396.jpeg');

-- Insert sample transport routes
INSERT INTO transport_routes (route_name, start_location, end_location, schedule_time, price, is_active) VALUES
('Campus Shuttle 1', 'Main Gate', 'Academic Block', '08:00:00', 2.00, true),
('Campus Shuttle 2', 'Hostel Area', 'Library', '09:00:00', 2.00, true),
('City Connect', 'Campus', 'City Center', '10:00:00', 5.00, true); 