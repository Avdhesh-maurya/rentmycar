# RentMyCar - Car Rental Platform

A full-stack car rental application built with React, Express, and MongoDB.

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
rentmycar/
├── client/                 # Frontend React application
│   ├── src/
│   │   ├── components/    # Reusable UI components
│   │   ├── pages/         # Page components
│   │   ├── context/       # React Context for state management
│   │   └── assets/        # Static assets
│   └── public/            # Public assets
│
├── server/                # Backend Node.js application
│   ├── configs/           # Configuration files (DB, ImageKit)
│   ├── controllers/       # Request handlers
│   ├── models/            # Mongoose models
│   ├── routes/            # API routes
│   └── middleware/        # Custom middleware (auth, multer)
│
├── render.yaml            # Render deployment config
├── Procfile               # Process file for Render
└── .env.example           # Environment variables template
```

## Installation & Setup

### Prerequisites
- Node.js 18.x or higher
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
CLIENT_URL=http://localhost:5173
PORT=3000
NODE_ENV=development
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

**For Production:** Update `VITE_BASE_URL` to `https://rent-chi-eight.vercel.app` to connect to the deployed backend.

**Note:** See [Frontend Configuration Guide](client/FRONTEND_CONFIGURATION.md) for detailed configuration options and troubleshooting.

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
- `CLIENT_URL` - Frontend URL for CORS (e.g., http://localhost:5173 for development)

### Client (.env)
- `VITE_BASE_URL` - Backend API URL
  - Development: `http://localhost:3000`
  - Production: `https://rent-chi-eight.vercel.app` (Vercel deployment)
- `VITE_CURRENCY` - Currency symbol for pricing

**See [Frontend Configuration Guide](client/FRONTEND_CONFIGURATION.md) for detailed setup instructions.**

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

## Deployment on Render

### Prerequisites
- GitHub account with your repository
- Render account (https://render.com)
- MongoDB Atlas account (for cloud database)
- ImageKit account (for image management)

### Step-by-Step Deployment Guide

#### 1. Prepare Your Repository
Ensure your code is pushed to GitHub:
```bash
git add .
git commit -m "Prepare for Render deployment"
git push origin main
```

#### 2. Configure MongoDB Atlas
1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a cluster and database
3. Get your connection string (with credentials)
4. Add Render's IP address to the IP whitelist (0.0.0.0/0 for testing)

#### 3. Create Render Service
1. Visit [Render Dashboard](https://dashboard.render.com)
2. Click "New +" → "Web Service"
3. Connect your GitHub repository
4. Select your repository and main branch

#### 4. Configure the Service
Fill in the following details:

- **Name:** `rentmycar-server`
- **Environment:** `Node`
- **Region:** Select closest to your users
- **Build Command:** 
  ```bash
  npm install && npm run build --prefix client && npm install --prefix server
  ```
- **Start Command:** 
  ```bash
  node server/server.js
  ```

#### 5. Add Environment Variables
In Render dashboard, go to **Environment** section and add:

| Variable | Value | Description |
|----------|-------|-------------|
| `MONGODB_URI` | Your MongoDB Atlas connection string | Database connection |
| `JWT_SECRET` | A strong random string | JWT secret key |
| `IMAGEKIT_PUBLIC_KEY` | Your ImageKit public key | Image upload |
| `IMAGEKIT_PRIVATE_KEY` | Your ImageKit private key | Image upload |
| `IMAGEKIT_URL_ENDPOINT` | Your ImageKit URL endpoint | Image delivery |
| `CLIENT_URL` | Your Render app URL | Frontend URL for CORS |
| `NODE_ENV` | `production` | Environment mode |
| `PORT` | `3000` | Server port |

#### 6. Deploy
Click "Deploy" and wait for the build to complete. Your app will be live at `https://your-app-name.onrender.com`

### Important Notes
- **Free Tier:** Services spin down after 15 minutes of inactivity. Use paid tier for production
- **Build Time:** First deployment takes 5-10 minutes
- **Logs:** Check deployment logs in Render dashboard for any errors
- **CORS:** Update `CLIENT_URL` in environment variables after getting your Render URL
- **MongoDB Access:** Whitelist Render's IP address in MongoDB Atlas security settings

### Monitoring and Maintenance
- Check logs in Render dashboard
- Monitor error rates and performance
- Update dependencies regularly
- Back up your MongoDB data

