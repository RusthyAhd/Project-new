const dotenv = require('dotenv')
dotenv.config();

const express = require('express');
const mongoose = require('mongoose');
const CustomResponse = require('./utils/custom.response');

// Import routes
const OwnerRouter = require('./routes/OwnerRoutes'); // Shop Owner routes
const ServiceProviderRouter = require('./routes/serviceProviderroutes'); // Service Provider routes
const profileRoutes = require('./routes/Profile.routes');
const AuthRoute = require('./routes/AuthRoutes');
const {sentOTP} = require("./utils/OTPService");
const {json, urlencoded} = require("body-parser");


// Initialize the express app
const app = express();

app.use(json());
app.use(urlencoded({ extended: true }));


// Enable Mongoose debug mode to log all queries
mongoose.set('debug', true);

// Connect to MongoDB
mongoose.connect('mongodb+srv://rusthy2001:rusthy.01122001@tapon-atlas.9qjax.mongodb.net/Tapon-DB?retryWrites=true&w=majority&appName=TapOn-Atlas')
    .then(() => console.log('MongoDB Successfully Connected with TapOn-DB'))
    .catch(error => {
        console.error('MongoDB Connection Error:', error.message);
    });

// Health check route to verify MongoDB connectivity
app.get('/serviceregistration', async (req, res) => {
    try {
        const test = await mongoose.connection.db.admin().ping(); // Check MongoDB connectivity
        
        // Log the test result in terminal
        console.log('MongoDB Ping Result:', test);

        res.status(200).send('MongoDB connection is working: ' + JSON.stringify(test));
    } catch (error) {
        console.error('MongoDB Ping Failed:', error.message); // Log the error to the terminal
        res.status(500).send('MongoDB connection failed: ' + error.message);
    }
});

app.get('/test', function (req, res, next) {

    res.status(200).send(
        new CustomResponse(
            200,
            'Harii...'
        )
    );

})



// Use middleware for parsing JSON (built-in Express middleware)
app.use(express.json());

// Define the routes for shop owner and service provider registration
app.use('/api/v1/shop', OwnerRouter);  // Shop owner routes are under /shopowner
app.use('/api/v1/service', ServiceProviderRouter); // Service provider routes are under /serviceprovider
app.use('/api/v1/profile', profileRoutes);
app.use('/api/v1/auth',AuthRoute)


// Define a simple route for the home page
app.get('/', (req, res) => {
    res.send("Hello TapOn Guys");
});

// Start the server and listen on port 3000
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
