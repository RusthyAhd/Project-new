const mongoose = require('mongoose'); 

const profileSchema = new mongoose.Schema({
    fullName: {
        type: String,
        required: false,
    },
    phoneNumber: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: false,
    },
    birthday: {
        type: Date,
        required: false,
    },
    gender: {
        type: String,
        enum: ['Male', 'Female', 'Other'],
        required: false
    },
    address: {
        type: String,
        required: false,
    },
    location: {
        type: String,
        required: false,
    },
    profilePhoto: {
        type: String, // You can change this to type Object if you are storing image files
    },
});

const Profile = mongoose.model('Profile', profileSchema);

module.exports = Profile;
