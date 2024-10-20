const express = require('express');
const router = express.Router();
const {createOrUpdateProfile }= require('../controllers/Profile.controller');
const {verifyToken} = require("../middleware/authMiddleware");


router.post('/cu', verifyToken, createOrUpdateProfile);

module.exports = router;
