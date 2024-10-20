const express = require('express'); // Import express
const ServiceProviderController = require('../controllers/ServiceProvider.controller');
const {verifyToken} = require("../middleware/authMiddleware"); // Import the controller

const router = express.Router(); // Create a new router

// Define the route for service provider registration
router.post('/serviceregistration', ServiceProviderController.serviceregister);

router.get('/service-providers/category/location', verifyToken, ServiceProviderController.getServiceProviders);

module.exports = router;
