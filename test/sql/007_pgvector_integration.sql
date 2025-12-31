-- test pgvector and pg_uuidv7 integration (PostgreSQL 17 only)
-- This test verifies both extensions can be used together

-- enable both extensions
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pg_uuidv7;

-- create a table with both UUIDv7 primary key and vector column
CREATE TABLE test_documents (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v7(),
    content text,
    embedding vector(128)
);

-- insert test data
INSERT INTO test_documents (content, embedding) 
VALUES ('test document', '[1,2,3,4,5]'::vector);

-- verify both extensions work together
SELECT id, content, embedding FROM test_documents;

-- verify UUIDv7 generation works
SELECT uuid_generate_v7() IS NOT NULL;

-- verify vector operations work
SELECT embedding <-> '[1,2,3,4,5]'::vector AS distance FROM test_documents;

-- cleanup
DROP TABLE test_documents;

