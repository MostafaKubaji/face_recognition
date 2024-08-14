const User = require("../models/user.model");
const express = require("express");
const router = express.Router();
const bcrypt = require('bcrypt'); // لتشفير كلمات المرور

// إنشاء حساب جديد
router.post("/signup", async (req, res) => {
  try {
    const { email, password } = req.body;

    // التحقق من صحة البيانات
    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }

    // التحقق من وجود المستخدم
    const existingUser = await User.findOne({ email: email });
    
    if (!existingUser) {
      // تشفير كلمة المرور
      const hashedPassword = await bcrypt.hash(password, 10);

      // إنشاء مستخدم جديد
      const newUser = new User({
        email: email,
        password: hashedPassword,
      });
      
      await newUser.save();
      console.log("New user created:", newUser);
      res.status(201).json(newUser);
    } else {
      console.log("Email is already in use:", email);
      res.status(400).json({ message: "Email is already in use" });
    }
  } catch (err) {
    console.error("Error during signup:", err);
    res.status(500).json({ error: err.message });
  }
});

// تسجيل الدخول
router.post("/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    // التحقق من صحة البيانات
    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }

    // البحث عن المستخدم
    const user = await User.findOne({ email: email });
    
    if (user && await bcrypt.compare(password, user.password)) {
      console.log("User signed in:", user.email);
      res.json(user);
    } else {
      console.log("Invalid email or password:", email);
      res.status(401).json({ message: "Invalid email or password" });
    }
  } catch (err) {
    console.error("Error during signin:", err);
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
