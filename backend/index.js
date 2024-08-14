const express = require('express');
const app = express();
const port = process.env.PORT || 8080;
const cors = require('cors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

// الاتصال بقاعدة البيانات
mongoose.connect("mongodb://192.168.94.119:27017/mydb", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  
.then(() => console.log("Connected to MongoDB"))
.catch((err) => console.error("Could not connect to MongoDB", err));

app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// إضافة المستخدمات
app.use('/', require('./routes/user.routes'));

// بدء الاستماع على المنفذ
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
