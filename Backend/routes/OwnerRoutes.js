const express = require('express'); // Import express package
const shopOwnerController = require('../controllers/Owner.Controller');


const router = express.Router();

// Update POST route for shop registration
// POST request to /api/v1/shop/registration
router.post('/registration', shopOwnerController.registerShopOwner);

router.get('/shop-shopowners/category/:category', shopOwnerController.getShopOwnersByCategory);

module.exports = router;



