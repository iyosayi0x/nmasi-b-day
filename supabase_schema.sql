-- Create a table for global site configuration (like the Chowdeck code)
CREATE TABLE site_config (
    id SERIAL PRIMARY KEY,
    key TEXT UNIQUE NOT NULL,
    value TEXT NOT NULL,
    description TEXT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert the initial Chowdeck code
INSERT INTO site_config (key, value, description)
VALUES ('chowdeck_code', 'LEGEND18', 'Voucher code for the Chowdeck gift modal');

-- Create a table for the story gallery (Act III)
CREATE TABLE gallery_images (
    id SERIAL PRIMARY KEY,
    url TEXT NOT NULL,
    label TEXT NOT NULL,
    display_time TEXT,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial gallery items (based on the current implementation)
INSERT INTO gallery_images (url, label, display_time, display_order)
VALUES 
('/act3_gallery_abstract_1.png', 'Chaos', '00.00', 0),
('https://picsum.photos/seed/41/400/600', 'Grace', '01.00', 1),
('https://picsum.photos/seed/42/400/600', 'Chaos', '02.00', 2),
('https://picsum.photos/seed/43/400/600', 'Grace', '03.00', 3),
('https://picsum.photos/seed/44/400/600', 'Chaos', '04.00', 4),
('https://picsum.photos/seed/45/400/600', 'Grace', '05.00', 5),
('https://picsum.photos/seed/46/400/600', 'Chaos', '06.00', 6),
('https://picsum.photos/seed/47/400/600', 'Grace', '07.00', 7),
('https://picsum.photos/seed/48/400/600', 'Chaos', '08.00', 8),
('https://picsum.photos/seed/49/400/600', 'Grace', '09.00', 9);
