<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Create Account | Medix</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Google Fonts + Font Awesome -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e9eef3 100%);
            min-height: 100vh;
            color: #1e293b;
            padding-bottom: 80px;
        }

        /* Header Section */
        .page-header {
            text-align: center;
            padding: 2rem 1rem 1rem;
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #1a6d5e 0%, #0f4c42 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #64748b;
            font-size: 0.95rem;
        }

        .avatar-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #e0f2fe 0%, #ccfbf1 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
        }

        .avatar-icon i {
            font-size: 2.5rem;
            color: #1a6d5e;
        }

        /* Form Container */
        .form-container {
            max-width: 1100px;
            margin: 1rem auto;
            padding: 0 1rem;
        }

        /* Modern Card */
        .register-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            padding: 2.5rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Two Column Layout */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem 2rem;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 0;
        }

        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.5rem;
        }

        .form-group label i {
            margin-right: 0.5rem;
            color: #1a6d5e;
            width: 20px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #1a6d5e;
            background: white;
            box-shadow: 0 0 0 4px rgba(26, 109, 94, 0.1);
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: #94a3b8;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
        }

        /* Radio Group */
        .radio-group {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            padding: 0.5rem 0;
        }

        .radio-group label {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: normal;
            margin-bottom: 0;
            cursor: pointer;
        }

        .radio-group input[type="radio"] {
            width: auto;
            margin: 0;
            cursor: pointer;
            accent-color: #1a6d5e;
        }

        /* Full Width Items */
        .full-width {
            grid-column: span 2;
        }

        @media (max-width: 768px) {
            .full-width {
                grid-column: span 1;
            }
        }

        /* Button Section */
        .button-section {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid #e2e8f0;
        }

        .btn-submit, .btn-reset {
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 40px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-submit {
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(26, 109, 94, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 109, 94, 0.4);
            background: linear-gradient(135deg, #145c4f 0%, #0f4c42 100%);
        }

        .btn-reset {
            background: #f1f5f9;
            color: #475569;
            border: 2px solid #e2e8f0;
        }

        .btn-reset:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        /* Footer */
        footer {
            background: white;
            color: #64748b;
            text-align: center;
            padding: 1rem;
            position: fixed;
            bottom: 0;
            width: 100%;
            border-top: 1px solid #e2e8f0;
            font-size: 0.85rem;
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }

        footer a {
            color: #1a6d5e;
            text-decoration: none;
            font-weight: 600;
        }

        footer a:hover {
            text-decoration: underline;
        }

        /* Required field indicator */
        .required::after {
            content: " *";
            color: #e74c3c;
        }

        /* Image styling */
        .header-image {
            text-align: center;
            margin: 0.5rem 0;
        }

        .header-image img {
            width: 100px;
            height: auto;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="page-header">
        <div class="avatar-icon">
            <i class="fas fa-user-plus"></i>
        </div>
        <h1>Create Your Account</h1>
        <p>Join Medix for seamless healthcare access</p>
    </div>

    <div class="form-container">
        <div class="register-card">
            <div class="header-image">
                <img src="sgn.png" alt="Sign Up" height="80" width="108">
            </div>

            <form name="regForm" method="post" action="Reg2" onsubmit="return validateForm()">
                <div class="form-grid">
                    <!-- Left Column -->
                    <div class="form-group">
                        <label class="required"><i class="fas fa-user"></i> Username</label>
                        <input type="text" name="n1" placeholder="Enter your full name"required>
                    </div>

                    <div class="form-group">
                        <label class="required"><i class="fas fa-venus-mars"></i> Gender</label>
                        <div class="radio-group">
                            <label><input type="radio" name="n2" value="male"> Male</label>
                            <label><input type="radio" name="n2" value="female"> Female</label>
                            <label><input type="radio" name="n2" value="other"> Other</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="required"><i class="fas fa-envelope"></i> Email Address</label>
                        <input type="email" name="n3" placeholder="Enter your email"required>
                    </div>

                    <div class="form-group">
                        <label class="required"><i class="fas fa-lock"></i> Password</label>
                        <input type="password" name="n4" placeholder="Create a password"required>
                    </div>

                    <div class="form-group">
                        <label class="required"><i class="fas fa-check-circle"></i> Confirm Password</label>
                        <input type="password" name="n5" placeholder="Re-enter your password"required>
                    </div>

                    <div class="form-group">
                        <label class="required"><i class="fas fa-calendar-alt"></i> Date of Birth</label>
                        <input type="date" name="n6">
                    </div>

                    <!-- Right Column -->
                    <div class="form-group">
                        <label class="required"><i class="fas fa-phone-alt"></i> Contact Number</label>
                        <input type="tel" name="n7" placeholder="Enter 10 digit mobile number"required>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-map-marker-alt"></i> Address</label>
                        <textarea rows="3" name="n8" placeholder="Enter your complete address"></textarea>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-question-circle"></i> Security Question</label>
                        <select name="n9">
                            <option value="null">Select a security question</option>
                            <option value="pet_name">What is your pet's name?</option>
                            <option value="Birthday">What is your birth city?</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-shield-alt"></i> Security Answer</label>
                        <input type="text" name="n10" placeholder="Enter your security answer">
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-tint"></i> Blood Group</label>
                        <input type="text" name="n11" placeholder="e.g., A+, B+, O+, AB-">
                    </div>
                </div>

                <div class="button-section">
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-user-check"></i> Create Account
                    </button>
                    <button type="reset" class="btn-reset">
                        <i class="fas fa-undo-alt"></i> Clear Form
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validateForm() {
            let pass = document.forms["regForm"]["n4"].value;
            let cpass = document.forms["regForm"]["n5"].value;
            
            if (pass !== cpass) {
                alert("❌ Passwords do not match!\nPlease re-enter your password.");
                return false;
            }
            
            // Optional: Add password strength check
            if (pass.length < 6) {
                alert("⚠️ Password should be at least 6 characters long.");
                return false;
            }
            
            // Optional: Validate phone number (10 digits)
            let phone = document.forms["regForm"]["n7"].value;
            if (phone && !/^\d{10}$/.test(phone)) {
                alert("📱 Please enter a valid 10-digit mobile number.");
                return false;
            }
            
            return true;
        }
    </script>

    <footer>
        <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to Home</a> | 
        <i class="fas fa-heartbeat" style="color: #e74c3c;"></i> Already have an account? <a href="patientlogin.jsp">Sign In</a>
    </footer>
</body>
</html>