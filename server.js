const express = require('express');
const cors = require('cors'); // Import CORS

const app = express();
const port = 3000;

app.use(cors()); // Enable CORS for all requests

app.get('/student', (req, res) => {
    const studentData = {
        name: "John Doe",
        age: 22,
        cgpa: 3.75,
        dept: "Computer Science"
    };
    res.json(studentData);
});

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
