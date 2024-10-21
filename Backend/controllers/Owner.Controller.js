const shopOwnerModel = require('../models/Owner.model');
const bcrypt = require('bcrypt');
const CustomResponse = require('../utils/custom.response');

// Register a new shop owner
exports.registerShopOwner = async (req, res) => {
    try {
      console.log('Request body:', req.body);
      const { name, shop_name, phone, address, location, email, description, password, category } = req.body;
  
      // Check if the shop owner already exists
      const existingOwner = await shopOwnerModel.findOne({ email });
      console.log('Existing owner:', existingOwner); 
      if (existingOwner) {
        return res.status(400).json({ message: 'Email already registered' });
      }
  // Before saving the shop owner
      const saltRounds = 10;
      const hashedPassword = await bcrypt.hash(password, saltRounds);
      // Create a new shop owner
      const newShopOwner = new shopOwnerModel({
        name,
        shop_name,
        phone,
        address,
        location,
        email,
        description,
        password: hashedPassword, 
        category,
      });
  
      // Save shop owner to the database
      await newShopOwner.save();
  
      res.status(200).json({ message: 'Registration successful', shopOwner: newShopOwner });
    } catch (error) {
      console.error('Error during shop owner registration:', error);
      res.status(500).json({ 
        message: 'Server error during registration',
        error:error });
    }
  };


  // Get Service Providers by Category (No Location Filter)
exports.getShopOwnersByCategory = async (req, res, next) => {

    try {
        const { category } = req.params;
        console.log(`Received request for category: ${category}`);
        // Check if the category is provided
        if (!category) {
            return res.status(400).send(
                new CustomResponse(
                    400,
                    'Please provide a category'
                )
            )
        }

        // Find all tools with the specified category
        const shopOwners = await shopOwnerModel.find({ category });

        if (shopOwners.length === 0) {
            return res.status(404).send(
                new CustomResponse(
                    404,
                    `No shops found for category: ${category}`
                )
            )
        }

        // Send the list of service providers
        res.status(200).send(
            new CustomResponse(
                200,
                `Shops for category: ${category}`,
                shopOwners
            )
        )

    } catch (error) {
        console.error(error);
        return res.status(500).send(
            new CustomResponse(
                404,
                'Failed to fetch shops'
            )
        )
    }
};
