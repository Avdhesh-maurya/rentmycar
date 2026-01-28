# RentMyCar - Render Deployment Guide

## Overview
This guide will help you deploy the RentMyCar application on Render.com. Render is a cloud platform that makes it easy to build and run apps.

## Prerequisites Checklist
- [ ] GitHub account with your code pushed
- [ ] Render account (sign up at https://render.com)
- [ ] MongoDB Atlas account with a cluster created
- [ ] ImageKit account with API keys
- [ ] All environment variables ready

## Step 1: Prepare Your Code

### 1.1 Update package.json (Root)
The root `package.json` should have a build and start script:
```json
{
  "scripts": {
    "build": "npm run build --prefix client && npm install --prefix server",
    "start": "node server/server.js"
  },
  "engines": {
    "node": "18.x"
  }
}
```

### 1.2 Verify server/package.json
Ensure the start script is present:
```json
{
  "scripts": {
    "start": "node server.js",
    "server": "nodemon server.js"
  }
}
```

### 1.3 Check server.js Configuration
Ensure your server is properly configured:
```javascript
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
```

### 1.4 Push to GitHub
```bash
git add .
git commit -m "Ready for Render deployment"
git push origin main
```

## Step 2: Set Up MongoDB Atlas

### 2.1 Create Cluster
1. Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
2. Create a new cluster (free tier is fine for testing)
3. Wait for cluster to be created

### 2.2 Create Database User
1. Go to "Database Access"
2. Create a database user with username and password
3. Note the credentials

### 2.3 Whitelist IP Addresses
1. Go to "Network Access"
2. Click "Add IP Address"
3. For development: Add your IP
4. For production on Render: Use `0.0.0.0/0` (allow all - not recommended for production)

### 2.4 Get Connection String
1. Click "Connect" on your cluster
2. Choose "Connect your application"
3. Copy the connection string
4. Replace `<username>` and `<password>` with your database credentials

Example format:
```
mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/rentmycar?retryWrites=true&w=majority
```

## Step 3: Set Up ImageKit Account

### 3.1 Create Account
1. Sign up at https://imagekit.io
2. Complete account setup

### 3.2 Get API Keys
1. Go to Settings → Developer Options
2. Note these values:
   - Public Key
   - Private Key
   - URL Endpoint

## Step 4: Deploy on Render

### 4.1 Connect GitHub
1. Visit https://render.com
2. Sign up/login
3. Click "New Web Service"
4. Connect your GitHub account
5. Select the rentmycar repository

### 4.2 Configure Service
Fill in the following:

| Field | Value |
|-------|-------|
| Name | `rentmycar-server` |
| Environment | Node |
| Region | Pick closest to your users |
| Branch | main |
| Build Command | `npm install && npm run build --prefix client && npm install --prefix server` |
| Start Command | `node server/server.js` |
| Plan | Free (or Starter for production) |

### 4.3 Add Environment Variables
In the "Environment" section, add each variable:

```
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/rentmycar?retryWrites=true&w=majority

JWT_SECRET=your-super-secret-jwt-key-change-this

IMAGEKIT_PUBLIC_KEY=your-imagekit-public-key

IMAGEKIT_PRIVATE_KEY=your-imagekit-private-key

IMAGEKIT_URL_ENDPOINT=https://ik.imagekit.io/your-url-endpoint

CLIENT_URL=https://your-app-name.onrender.com

NODE_ENV=production

PORT=3000
```

### 4.4 Deploy
1. Review all settings
2. Click "Create Web Service"
3. Render will start building and deploying
4. Check the logs for any errors
5. Once deployed, you'll get your app URL

## Step 5: Verify Deployment

### 5.1 Test the Server
Open your browser and visit:
```
https://your-app-name.onrender.com/
```

You should see: "Server is running"

### 5.2 Test API
Try accessing an API endpoint:
```
https://your-app-name.onrender.com/api/user/cars
```

### 5.3 Check Logs
In Render dashboard:
1. Go to your service
2. Click "Logs" to see server output
3. Check for any error messages

## Step 6: Configure Frontend (Optional)

If you want to deploy frontend separately on Render:

### 6.1 Create Frontend Service
1. Click "New" → "Static Site"
2. Connect your GitHub repo
3. Configure build:
   - Build Command: `cd client && npm run build`
   - Publish Directory: `client/dist`

### 6.2 Update API Base URL
In your client code, update the API base URL to point to your backend:
```javascript
// In your API client config
const API_BASE_URL = process.env.VITE_API_URL || 'https://your-app-name.onrender.com/api';
```

## Important Notes

### Free Tier Limitations
- Services spin down after 15 minutes of inactivity
- This causes a ~30 second cold start delay
- Upgrade to Starter tier for production use

### Database Security
- Don't use `0.0.0.0/0` for production
- Use a VPC or specific IP whitelist
- Regularly rotate database credentials

### CORS Configuration
- Update `CLIENT_URL` in environment variables
- This is used in your server's CORS configuration
- Ensure it matches your frontend URL

### Monitoring
- Check deployment logs regularly
- Set up email notifications for failures
- Monitor database connections
- Keep dependencies updated

## Troubleshooting

### Build Fails
- Check build logs in Render dashboard
- Verify `package.json` files exist in root and server
- Ensure Node version is compatible (18.x)

### Server Won't Start
- Check environment variables are set correctly
- Verify MongoDB connection string
- Look for port binding errors in logs

### Database Connection Issues
- Verify MongoDB Atlas whitelist includes Render IP
- Check credentials in MONGODB_URI
- Ensure database user has proper permissions

### CORS Errors
- Update CLIENT_URL to match your frontend domain
- Restart the service after changing environment variables

## Useful Commands

### View Logs
```bash
# In Render dashboard, go to your service and click "Logs"
```

### Restart Service
```bash
# In Render dashboard, click "Manual Deploy" → "Deploy latest commit"
```

### Update Environment Variables
1. Go to your service
2. Go to "Environment"
3. Update the variable
4. Service restarts automatically

## Next Steps

1. Set up monitoring and alerts
2. Configure custom domain (if desired)
3. Set up SSL/HTTPS (automatic on Render)
4. Configure auto-deployment on git push
5. Set up database backups
6. Monitor performance and costs

## Support

- Render Documentation: https://render.com/docs
- MongoDB Atlas Help: https://docs.mongodb.com/atlas/
- ImageKit Documentation: https://docs.imagekit.io

## Quick Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] MongoDB Atlas cluster created with user
- [ ] ImageKit account created with API keys
- [ ] Render account created
- [ ] GitHub connected to Render
- [ ] Service created with correct build/start commands
- [ ] All environment variables added
- [ ] Deployment successful
- [ ] Server responding to requests
- [ ] API endpoints working
- [ ] Database operations working
- [ ] Image upload working

---

Happy deploying! 🚀
