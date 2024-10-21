const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
// Define the Owner schema
const shopOwnerSchema = new mongoose.Schema({
    name: { type: String, required: true },
    shop_name: { type: String, required: true },
    phone: { type: String, required: true, unique: true },
    address: { type: String, required: true },
    location: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    description: { type: String },
    password: { type: String, required: true },
    category: { type: String, required: true },  
}, { timestamps: true });

// Check if the model is already compiled to prevent OverwriteModelError
const shopOwnerModel = mongoose.models.Shopowner_register || mongoose.model('Shopowner_register', shopOwnerSchema);

module.exports = shopOwnerModel;
