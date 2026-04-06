<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>
<%
    if (session.getAttribute("adminEmail") == null) {
        response.sendRedirect("alogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Doctor | Medix</title>
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

        /* Main Container */
        .form-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem;
        }

        /* Form Card */
        .form-card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
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

        /* Form Header */
        .form-header {
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            padding: 2rem;
            text-align: center;
            color: white;
        }

        .form-header-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
        }

        .form-header-icon i {
            font-size: 2.5rem;
            color: white;
        }

        .form-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .form-header p {
            opacity: 0.9;
            font-size: 0.9rem;
        }

        /* Form Body */
        .form-body {
            padding: 2rem;
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        @media (max-width: 640px) {
            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
        }

        /* Form Groups */
        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        @media (max-width: 640px) {
            .form-group.full-width {
                grid-column: span 1;
            }
        }

        .form-group label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group label i {
            color: #1a6d5e;
            width: 20px;
        }

        .required-field::after {
            content: " *";
            color: #ef4444;
        }

        .form-group input,
        .form-group select {
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 20px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #1a6d5e;
            background: white;
            box-shadow: 0 0 0 4px rgba(26, 109, 94, 0.1);
        }

        .form-group input::placeholder {
            color: #94a3b8;
        }

        /* Submit Button */
        .submit-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
            margin-top: 1.5rem;
            box-shadow: 0 4px 12px rgba(26, 109, 94, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 109, 94, 0.4);
            background: linear-gradient(135deg, #145c4f 0%, #0f4c42 100%);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        /* Back Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1.5rem;
            padding: 0.75rem 1.5rem;
            background: white;
            color: #1a6d5e;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .back-link:hover {
            background: #1a6d5e;
            color: white;
            transform: translateX(-5px);
        }

        /* Info Note */
        .info-note {
            margin-top: 1.5rem;
            padding: 0.8rem;
            background: #fef3c7;
            border-radius: 16px;
            font-size: 0.75rem;
            color: #92400e;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-note i {
            font-size: 1rem;
        }

        /* Responsive */
        @media (max-width: 480px) {
            .form-container {
                margin: 1rem auto;
            }
            
            .form-header {
                padding: 1.5rem;
            }
            
            .form-header h2 {
                font-size: 1.4rem;
            }
            
            .form-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="form-container">
        <div class="form-card">
            <div class="form-header">
                <div class="form-header-icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <h2>Register New Doctor</h2>
                <p>Add a physician to the hospital system</p>
            </div>

            <div class="form-body">
                <form action="AddDoctor" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="required-field"><i class="fas fa-user"></i> Full Name</label>
                            <input type="text" name="name" placeholder="Dr. John Doe" required>
                        </div>

                        <div class="form-group">
                            <label class="required-field"><i class="fas fa-stethoscope"></i> Specialization</label>
                            <select name="specialization" required>
                                <option value="">-- Select Specialization --</option>
                                <option value="Cardiologist">❤️ Cardiologist</option>
                                <option value="Gynecologist">👩‍⚕️ Gynecologist</option>
                                <option value="Dentist">🦷 Dentist</option>
                                <option value="Orthopedic">🦴 Orthopedic</option>
                                <option value="Neurologist">🧠 Neurologist</option>
                                <option value="General Physician">🏥 General Physician</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="required-field"><i class="fas fa-envelope"></i> Email Address</label>
                            <input type="email" name="email" placeholder="doctor@medix.com" required>
                        </div>

                        <div class="form-group">
                            <label class="required-field"><i class="fas fa-phone-alt"></i> Phone Number</label>
                            <input type="text" name="phone" placeholder="+91 98765 43210" required>
                        </div>

                        <div class="form-group">
                            <label class="required-field"><i class="fas fa-rupee-sign"></i> Consultation Fee</label>
                            <input type="number" name="fees" placeholder="500" required>
                        </div>

                        <div class="form-group">
                            <label class="required-field"><i class="fas fa-graduation-cap"></i> Degree</label>
                            <input type="text" name="degree" placeholder="MBBS, MD, DM" required>
                        </div>

                        <div class="form-group full-width">
                            <label class="required-field"><i class="fas fa-lock"></i> Temporary Password</label>
                            <input type="password" name="password" placeholder="Create a secure password" required>
                        </div>
                    </div>

                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i> Register Doctor
                    </button>
                </form>

                <div class="info-note">
                    <i class="fas fa-info-circle"></i>
                    The doctor will receive login credentials via email. They can change their password after first login.
                </div>

                <div style="text-align: center;">
                    <a href="adash.jsp" class="back-link">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>