# Car Rental Fullstack Application

A modern, full-stack car rental platform built with React, Node.js, Express, and MongoDB. This application allows users to browse and book cars, while car owners can manage their fleet and bookings through a dedicated dashboard.

## Features

### User Features
- User authentication (Register/Login with JWT)
- Browse available cars with detailed information
- Book cars with pickup and return dates
- View and manage personal bookings
- Responsive design for mobile and desktop

### Owner Features
- Owner dashboard for fleet management
- Add new cars with images (ImageKit integration)
- Manage car availability
- View and manage all bookings
- Track rental statistics

## Tech Stack

### Frontend
- **React** - UI library
- **Vite** - Build tool and dev server
- **React Router** - Client-side routing
- **Axios** - HTTP client
- **TailwindCSS** - Styling
- **React Hot Toast** - Notifications
- **Motion** - Animations

### Backend
- **Node.js** - Runtime environment
- **Express** - Web framework
- **MongoDB** - Database
- **Mongoose** - ODM
- **JWT** - Authentication
- **bcrypt** - Password hashing
- **ImageKit** - Image storage and optimization
- **Multer** - File upload handling

## Project Structure

```
CarRental-fullstack/
├── client/                 # Frontend React application
│   ├── src/
│   │   ├── components/    # Reusable UI components
│   │   ├── pages/         # Page components
│   │   ├── context/       # React Context for state management
│   │   └── assets/        # Static assets
│   └── public/            # Public assets
│
└── server/                # Backend Node.js application
    ├── configs/           # Configuration files (DB, ImageKit)
    ├── controllers/       # Request handlers
    ├── models/            # Mongoose models
    ├── routes/            # API routes
    └── middleware/        # Custom middleware (auth, multer)
```

## Installation & Setup

### Prerequisites
- Node.js (v14 or higher)
- MongoDB Atlas account or local MongoDB
- ImageKit account for image storage

### Backend Setup

1. Navigate to server directory:
```bash
cd server
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file in the server directory:
```env
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret
IMAGEKIT_PUBLIC_KEY=your_imagekit_public_key
IMAGEKIT_PRIVATE_KEY=your_imagekit_private_key
IMAGEKIT_URL_ENDPOINT=your_imagekit_url_endpoint
```

4. Start the server:
```bash
npm run server    # Development with nodemon
# or
npm start         # Production
```

The server will run on `http://localhost:3000`

### Frontend Setup

1. Navigate to client directory:
```bash
cd client
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file in the client directory:
```env
VITE_BASE_URL=http://localhost:3000
VITE_CURRENCY=$
```

4. Start the development server:
```bash
npm run dev
```

The client will run on `http://localhost:5173`

## API Endpoints

### User Routes (`/api/user`)
- `POST /register` - Register new user
- `POST /login` - Login user
- `GET /data` - Get user data (protected)
- `GET /cars` - Get all available cars

### Owner Routes (`/api/owner`)
- `POST /add-car` - Add new car (protected, owner only)
- `GET /cars` - Get owner's cars (protected, owner only)
- `PUT /cars/:id` - Update car details (protected, owner only)
- `DELETE /cars/:id` - Delete car (protected, owner only)

### Booking Routes (`/api/bookings`)
- `POST /create` - Create new booking (protected)
- `GET /user` - Get user's bookings (protected)
- `GET /owner` - Get owner's bookings (protected, owner only)
- `PUT /:id/status` - Update booking status (protected, owner only)

## Environment Variables

### Server (.env)
- `MONGODB_URI` - MongoDB connection string
- `JWT_SECRET` - Secret key for JWT tokens
- `IMAGEKIT_PUBLIC_KEY` - ImageKit public key
- `IMAGEKIT_PRIVATE_KEY` - ImageKit private key
- `IMAGEKIT_URL_ENDPOINT` - ImageKit URL endpoint

### Client (.env)
- `VITE_BASE_URL` - Backend API URL
- `VITE_CURRENCY` - Currency symbol for pricing

## Usage

1. **User Registration**: Create an account using the signup form
2. **Browse Cars**: View available cars on the home page
3. **Book a Car**: Select dates and book your preferred car
4. **Owner Dashboard**: Login as owner to access the management dashboard
5. **Manage Fleet**: Add, edit, or remove cars from your fleet
6. **Handle Bookings**: View and manage customer bookings

## Authentication

The application uses JWT (JSON Web Tokens) for authentication:
- Tokens are generated on login/register
- Stored in localStorage on the client
- Sent in the Authorization header for protected routes
- Verified by the `protect` middleware on the server

## Database Models

### User Model
- name, email, password
- role (user/owner)

### Car Model
- name, brand, model, year
- price, features, availability
- owner reference
- images (stored in ImageKit)

### Booking Model
- user, car references
- pickup/return dates
- total price
- booking status

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is open source and available under the MIT License.

## Support

For support, email your-email@example.com or create an issue in the repository.
