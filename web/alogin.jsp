<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | Medix</title>
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
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            min-height: 100vh;
            position: relative;
        }

        /* Decorative admin background elements */
        body::before {
            content: "👑";
            position: absolute;
            font-size: 300px;
            opacity: 0.03;
            bottom: 0;
            right: 0;
            pointer-events: none;
            z-index: 0;
        }

        body::after {
            content: "⚙️";
            position: absolute;
            font-size: 250px;
            opacity: 0.03;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 0;
        }

        /* Main Container */
        .login-container {
            width: 100%;
            max-width: 500px;
            margin: 2rem auto;
            padding: 1rem;
            z-index: 1;
            position: relative;
        }

        /* Modern Card */
        .login-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            border-radius: 40px;
            box-shadow: 0 30px 60px -20px rgba(0, 0, 0, 0.5);
            padding: 2.5rem;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 35px 70px -20px rgba(0, 0, 0, 0.6);
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

        .admin-icon {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, #2c3e50 0%, #1a1a2e 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            border: 3px solid rgba(255, 215, 0, 0.3);
        }

        .admin-icon i {
            font-size: 3rem;
            color: #ffd700;
        }

        .login-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #64748b;
            font-size: 0.9rem;
        }

        /* Form Styling */
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
            color: #2c3e50;
        }

        .input-group input {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 20px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
        }

        .input-group input:focus {
            outline: none;
            border-color: #2c3e50;
            background: white;
            box-shadow: 0 0 0 4px rgba(44, 62, 80, 0.1);
        }

        .input-group input::placeholder {
            color: #94a3b8;
        }

        /* Button */
        .login-button {
            width: 100%;
            padding: 0.875rem;
            background: linear-gradient(135deg, #2c3e50 0%, #1a1a2e 100%);
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
            background: linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%);
        }

        .login-button:active {
            transform: translateY(0);
        }

        /* Footer */
        .login-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid #e2e8f0;
        }

        .back-link {
            color: #2c3e50;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: #1a1a2e;
            transform: translateX(-3px);
        }

        /* Admin badge */
        .admin-badge {
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(255, 215, 0, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 40px;
            font-size: 0.75rem;
            color: #ffd700;
            border: 1px solid rgba(255, 215, 0, 0.3);
            backdrop-filter: blur(5px);
            z-index: 100;
        }

        .admin-badge i {
            margin-right: 0.3rem;
        }

        /* Responsive Design */
        @media (max-width: 640px) {
            .login-card {
                padding: 1.8rem;
            }
            
            .login-header h2 {
                font-size: 1.5rem;
            }
            
            .admin-icon {
                width: 70px;
                height: 70px;
            }
            
            .admin-icon i {
                font-size: 2.2rem;
            }
            
            .admin-badge {
                font-size: 0.7rem;
                padding: 0.3rem 0.8rem;
                top: 10px;
                right: 10px;
            }
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 0.8rem;
                margin: 1rem auto;
            }
            
            .login-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="admin-badge">
        <i class="fas fa-shield-alt"></i> Secure Admin Portal
    </div>

    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <div class="admin-icon">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h2>Admin Access</h2>
                <p>Secure administrative dashboard login</p>
            </div>

            <form action="Alogin" method="post" class="login-form">
                <div class="input-group">
                    <label><i class="fas fa-envelope"></i> Admin Email</label>
                    <input type="email" name="email" placeholder="admin@medix.com" required class="login-input">
                </div>

                <div class="input-group">
                    <label><i class="fas fa-lock"></i> Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required class="login-input">
                </div>

                <button type="submit" class="login-button">
                    <i class="fas fa-arrow-right-to-bracket"></i> Login as Admin
                </button>
            </form>

            <footer class="login-footer">
                <a href="login.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>
            </footer>
        </div>
    </div>
</body>
</html>