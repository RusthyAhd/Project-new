const ShopOwnerModel = require('../models/Owner.model'); // Import the Owner model
const bcrypt = require('bcrypt');
const CustomResponse = require("../utils/custom.response"); // Import bcrypt for password hashing

// Controller method to handle the registration
exports.register = async (req, res) => {
    try {
        // Destructure fields from request body
        const { name, shop_name, phone, address, location, email, category, password, confirmPassword } = req.body;
        
        // Validate input
        if (!name || !shop_name || !phone || !address || !location || !email || !category || !password || !confirmPassword) {
            return res.status(400).send(
                new CustomResponse(
                    400,
                    'All fields are required'
                )
            )
        }

        // Check if passwords match
        if (password !== confirmPassword) {
            return res.status(400).send(
                new CustomResponse(
                    400,
                    'Passwords do not match'
                )
            )
        }

        // Hash the password before saving
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create new owner directly inside the controller
        const newOwner = new ShopOwnerModel({
            name,
            shop_name,
            phone,
            address,
            location,
            email,
            category,
            password: hashedPassword, // Store the hashed password
        });

        // Save to the database
        const savedOwner = await newOwner.save();
        
        // Respond with a success message
        res.status(200).send(
            new CustomResponse(
                200,
                `Shop owner registered successfully`,
                savedOwner
            )
        )
    } catch (error) {
        console.error(error);
        return res.status(500).send(
            new CustomResponse(
                404,
                'Registration failed. Try again later.'
            )
        )
    }
};

exports.getShopsByCategoryAndLocation = async (req, res, next) => {

    const { category, location } = req.body;

    // Check if both category and location are provided
    if (!category || !location) {
        return res.status(400).send(
            new CustomResponse(
                400,
                'Please provide both category and location'
            )
        )
    }

    try {
        // Find all shop owners by category and location
        const shopOwners = await ShopOwnerModel.find({ category, location });

        if (shopOwners.length === 0) {
            return res.status(404).send(
                new CustomResponse(
                    404,
                    `No shop owners found for category: ${category} and location: ${location}`
                )
            )
        }

        // Return the list of shop owners
        res.status(200).send(
            new CustomResponse(
                200,
                `Shop owners for category: ${category} and location: ${location}`,
                shopOwners
            )
        )

    } catch (error) {

        console.error('Error fetching shop owners:', error);

        return res.status(500).send(
            new CustomResponse(
                404,
                'Failed to fetch shop owners',
                {
                    message: 'An error occurred while fetching shop owners',
                    error: error.message
                }
            )
        )
    }

}
