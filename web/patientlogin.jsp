<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Patient Login | Medix</title>
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
        }

        /* Navbar include styling - original remains functional */
        center:first-of-type {
            display: block;
            margin-bottom: 1rem;
        }

        /* Main Container */
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px);
            padding: 2rem 1rem;
        }

        /* Modern Card */
        .login-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            padding: 2.5rem;
            max-width: 480px;
            width: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.3);
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

        /* Header Section */
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
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

        .login-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #64748b;
            font-size: 0.9rem;
        }

        /* Image Styling - kept but modernized */
        .patient-image {
            text-align: center;
            margin-bottom: 0.5rem;
        }

        .patient-image img {
            width: 120px;
            height: 120px;
            object-fit: contain;
            border-radius: 60px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            background: white;
            padding: 0.5rem;
        }

        /* Form Styling - DIV based layout, no tables */
        .login-form {
            margin-top: 1.5rem;
        }

        .input-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .input-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.5rem;
        }

        .input-group label i {
            margin-right: 0.5rem;
            color: #1a6d5e;
        }

        .input-group input {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
        }

        .input-group input:focus {
            outline: none;
            border-color: #1a6d5e;
            background: white;
            box-shadow: 0 0 0 4px rgba(26, 109, 94, 0.1);
        }

        .input-group input::placeholder {
            color: #94a3b8;
        }

        /* Button Group */
        .button-group {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .btn-submit, .btn-reset {
            flex: 1;
            padding: 0.875rem;
            border: none;
            border-radius: 16px;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
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

        /* Links Section */
        .links-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 1rem;
            border-top: 1px solid #e2e8f0;
            margin-top: 0.5rem;
        }

        .links-section a {
            color: #1a6d5e;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .links-section a:hover {
            color: #0f4c42;
            text-decoration: none;
            transform: translateX(3px);
        }

        .signup-link {
            text-align: right;
        }

        .signup-link a {
            font-size: 0.9rem;
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

        /* Responsive Design */
        @media (max-width: 640px) {
            .login-card {
                padding: 1.5rem;
                margin: 1rem;
            }
            
            .login-header h2 {
                font-size: 1.5rem;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .links-section {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .signup-link {
                text-align: center;
            }
        }

        /* Keep original navbar styling compatibility */
        nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
}
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <div class="avatar-icon">
                    <i class="fas fa-user-injured"></i>
                </div>
                <h2>Welcome Back!</h2>
                <p>Sign in to manage your appointments</p>
            </div>
            
            <div class="patient-image">
                <img src="signin.jpg" alt="Patient Login">
            </div>
            
            <form method="post" action="Pl2" class="login-form">
                <div class="input-group">
                    <label><i class="fas fa-envelope"></i> Email Address</label>
                    <input type="email" name="n1" placeholder="Enter your email" required>
                </div>
                
                <div class="input-group">
                    <label><i class="fas fa-lock"></i> Password</label>
                    <input type="password" name="n2" placeholder="Enter your password" required>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-arrow-right-to-bracket"></i> Sign In
                    </button>
                    <button type="reset" class="btn-reset">
                        <i class="fas fa-undo-alt"></i> Clear
                    </button>
                </div>
                
                <div class="links-section">
                    <a href="forgotpass.jsp">
                        <i class="fas fa-key"></i> Forgot Password?
                    </a>
                    <div class="signup-link">
                        <a href="register.jsp">
                            <i class="fas fa-user-plus"></i> Create Account
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <footer>
        <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to Home</a> | 
        <i class="fas fa-heartbeat" style="color: #e74c3c;"></i> Medix Patient Portal
    </footer>
</body>
</html>