const express = require('express'); // Import express package
const OwnerController = require('../controllers/Owner.Controller');
const {verifyToken} = require("../middleware/authMiddleware"); // Import the controller

const router = express.Router();

// Update POST route for shop registration
router.post('/registration', OwnerController.register);

router.get('/get/all/category/location', verifyToken, OwnerController.getShopsByCategoryAndLocation);

module.exports = router;
