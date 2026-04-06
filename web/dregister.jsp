<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Doctor Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #007bff;
            text-align: center;
            margin-bottom: 25px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        input, select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 15px;
            font-size: 14px;
        }
        button {
            padding: 12px;
            background: #007bff;
            border: none;
            border-radius: 6px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover {
            background: #0056b3;
        }
        .back-link {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register New Doctor</h2>

        <form method="post" action="dregister">
            <label>Name:</label>
            <input type="text" name="name" required>

            <label>Specialization:</label>
            <select name="specialization" required>
                <option value="">--Select--</option>
                <option value="Cardiologist">Cardiologist</option>
                <option value="Gynecologist">Gynecologist</option>
                <option value="Dentist">Dentist</option>
                <option value="Orthopedic">Orthopedic</option>
                <option value="Neurologist">Neurologist</option>
                <option value="General Physician">General Physician</option>
            </select>

            <label>Email:</label>
            <input type="email" name="email" required>

            <label>Phone:</label>
            <input type="text" name="phone" required>

            <label>Degree:</label>
            <input type="text" name="degree" required>

            <label>Fees:</label>
            <input type="number" name="fees" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <button type="submit">Register Doctor</button>
        </form>

        <a href="adash.jsp" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>
