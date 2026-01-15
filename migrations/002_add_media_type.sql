-- Migration: 002_add_media_type
-- Description: Add media_type column to gallery_images to support both images and videos
-- Date: 2026-01-15

-- Create an enum type for media types
CREATE TYPE media_type AS ENUM ('IMAGE', 'VIDEO');

-- Add media_type column to gallery_images with default value 'IMAGE'
ALTER TABLE gallery_images 
ADD COLUMN media_type media_type NOT NULL DEFAULT 'IMAGE';

-- Add a comment for documentation
COMMENT ON COLUMN gallery_images.media_type IS 'Type of media: IMAGE or VIDEO';
