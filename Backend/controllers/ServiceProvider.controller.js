const ServiceProviderModel = require('../models/serviceProvider.model'); // Import the model
const bcrypt = require('bcrypt');
const CustomResponse = require('../utils/custom.response');

// Register Service Provider
exports.serviceregister = async (req, res, next) => {
    try {
        const { name, service_title, phone, address, location, email, category, description, password } = req.body;

        // Validate required fields
        if (!name || !service_title || !phone || !address || !location || !email || !category || !description || !password) {
            return res.status(400).send(
                new CustomResponse(
                    400,
                    'All fields are required'
                )
            )
        }

        // Check for existing phone or email
        const existingProvider = await ServiceProviderModel.findOne({ $or: [{ phone }, { email }] });
        if (existingProvider) {
            return res.status(400).send(
                new CustomResponse(
                    400,
                    'Phone or email already exists'
                )
            )
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create a new service provider entry
        const newServiceProvider = new ServiceProviderModel({
            name,
            service_title,
            phone,
            address,
            location,
            email,
            category,
            description,
            password: hashedPassword, // Store hashed password
        });

        // Save to the database
        const savedServiceProvider = await newServiceProvider.save();

        // Send response back
        res.status(200).send(
            new CustomResponse(
                200,
                `Service provider registered successfully`,
                savedServiceProvider
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

// Get all Service Providers
exports.getServiceProviders = async (req, res, next) => {

    try {

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

        // Find all service providers with the specified category
        const serviceProviders = await ServiceProviderModel.find({ category , location });

        if (serviceProviders.length === 0) {
            return res.status(404).send(
                new CustomResponse(
                    404,
                    `No service providers found for category: ${category} and location: ${location}`
                )
            )
        }

        // Send the list of service providers
        res.status(200).send(
            new CustomResponse(
                200,
                `Service providers for category: ${category}`,
                serviceProviders
            )
        )

    } catch (error) {
        console.error(error);
        return res.status(500).send(
            new CustomResponse(
                404,
                'Failed to fetch service providers'
            )
        )
    }

};
