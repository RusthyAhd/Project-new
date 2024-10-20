const express = require('express'); // Import express
const ServiceProviderController = require('../controllers/ServiceProvider.controller');

const router = express.Router(); // Create a new router

// Define the route for service provider registration
router.post('/serviceregistration', ServiceProviderController.serviceregister);

// Define the route to get service providers by category
router.get('/service-providers/category/:category', ServiceProviderController.getServiceProvidersByCategory);

module.exports = router;
