Simple Drive
============

Simple Drive is a Ruby on Rails application designed to showcase software engineering principles such as object orientation and abstraction. It provides a unified interface for storing and retrieving objects or files across multiple storage backends, including Amazon S3 Compatible Storage, Database Tables, the Local File System.

Features
--------

*   **Store and Retrieve Blobs**: Use unique identifiers to store and retrieve Base64 encoded binary data.
*   **Multiple Storage Backends**: Support for various storage solutions including Amazon S3 Compatible Storage, Database Tables, Local File System, and FTP.
*   **Bearer Token Authentication**: Secure API access with Bearer token authentication.
*   **Flexible Storage Configuration**: Easily configure the storage backend through environment variables.

Getting Started
---------------

### Prerequisites

*   Ruby on Rails

### Installation

1.  Clone the repository:
    
    bashCopy code
    
    `git clone https://github.com/yourusername/simple_drive.git`
    
2.  Navigate to the project directory:
    
    bashCopy code
    
    `cd simple_drive`
    
3.  Install dependencies:
    
    Copy code
    
    `bundle install`
    
4.  Set up your environment variables in `.env` file:

DATABASE_HOST=your_database_host

DATABASE_NAME=your_database_name

BUCKET=your_bucket_name

SECRET_ACCESS_KEY=your_secret_access_key

ACCESS_KEY=your_access_key

DIGITALOCEAN_ENDPOINT=your_digitalocean_endpoint_if_applicable

FILE_PATH=your_local_file_storage_path

#Service type: 1 for Amazon S3, 2 for Database, 3 for Local File System

SERVICE_TYPE=1
    

### Running the Application

Start the Rails server:

Copy code

`rails s`

Usage
-----

### Storing a Blob

Send a POST request to `/v1/blobs` with the following JSON object:

jsonCopy code

`{   "id": "unique_identifier",   "data": "Base64EncodedData" }`

### Retrieving a Blob

Send a GET request to `/v1/blobs/<id>` to retrieve the stored blob.

Authentication
--------------

This application uses Bearer token authentication. Ensure to include a valid token in the `Authorization` header of your requests.
this is just to demonstrate an example of authentication 
the bearer token is `valid_token`

Acknowledgments
---------------
*   Moyasar for the project requirements.
