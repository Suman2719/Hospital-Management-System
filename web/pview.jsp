<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String email = (String) session.getAttribute("patientEmail");
    if (email == null) {
        response.sendRedirect("patientlogin.jsp");
        return;
    }

    String name = "", gender = "", contact = "", address = "", bloodgrp = "";
    String successMsg = "";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            name = request.getParameter("name");
            gender = request.getParameter("gender");
            contact = request.getParameter("contact");
            address = request.getParameter("address");
            bloodgrp = request.getParameter("bloodgrp");

            String update = "update preg set name=?, gender=?, cno=?, address=?, bloodgrp=? where email=?";
            PreparedStatement ps = con.prepareStatement(update);
            ps.setString(1, name);
            ps.setString(2, gender);
            ps.setString(3, contact);
            ps.setString(4, address);
            ps.setString(5, bloodgrp);
            ps.setString(6, email);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                successMsg = "✅ Profile updated successfully!";
            }
            ps.close();
        }

        String q1 = "select name, gender, cno, address, bloodgrp from preg where email=?";
        PreparedStatement ps2 = con.prepareStatement(q1);
        ps2.setString(1, email);
        ResultSet rs = ps2.executeQuery();

        if (rs.next()) {
            name = rs.getString(1);
            gender = rs.getString(2);
            contact = rs.getString(3);
            address = rs.getString(4);
            bloodgrp = rs.getString(5);
        }

        con.close();
    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile | Medix</title>
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
        .profile-container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 1rem;
        }

        /* Profile Card */
        .profile-card {
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

        /* Profile Header */
        .profile-header {
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            padding: 2rem;
            text-align: center;
            color: white;
            position: relative;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            border: 3px solid rgba(255, 255, 255, 0.3);
        }

        .profile-avatar i {
            font-size: 3rem;
            color: white;
        }

        .profile-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .profile-header p {
            opacity: 0.9;
            font-size: 0.85rem;
        }

        .profile-email-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.15);
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.8rem;
            margin-top: 0.8rem;
        }

        .profile-email-badge i {
            margin-right: 0.4rem;
        }

        /* Profile Body */
        .profile-body {
            padding: 2rem;
        }

        /* Success Message */
        .success-message {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
            padding: 1rem;
            border-radius: 16px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-weight: 500;
            animation: slideIn 0.4s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .success-message i {
            font-size: 1.2rem;
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

        .form-group input {
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 20px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
        }

        .form-group input:focus {
            outline: none;
            border-color: #1a6d5e;
            background: white;
            box-shadow: 0 0 0 4px rgba(26, 109, 94, 0.1);
        }

        .form-group input::placeholder {
            color: #94a3b8;
        }

        .form-group input:read-only {
            background: #f1f5f9;
            cursor: not-allowed;
        }

        /* Button Section */
        .button-section {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid #e2e8f0;
        }

        .btn-update, .btn-back {
            padding: 0.875rem 1.5rem;
            border: none;
            border-radius: 40px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-update {
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            flex: 2;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(26, 109, 94, 0.3);
        }

        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 109, 94, 0.4);
            background: linear-gradient(135deg, #145c4f 0%, #0f4c42 100%);
        }

        .btn-back {
            background: #f1f5f9;
            color: #475569;
            border: 2px solid #e2e8f0;
            flex: 1;
            justify-content: center;
        }

        .btn-back:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        .btn-update:active, .btn-back:active {
            transform: translateY(0);
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
            .profile-container {
                margin: 1rem auto;
            }
            
            .profile-header {
                padding: 1.5rem;
            }
            
            .profile-body {
                padding: 1.5rem;
            }
            
            .button-section {
                flex-direction: column;
            }
            
            .btn-update, .btn-back {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="profile-container">
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fas fa-user-circle"></i>
                </div>
                <h2>My Profile</h2>
                <p>Manage your personal information</p>
                <div class="profile-email-badge">
                    <i class="fas fa-envelope"></i> <%= email %>
                </div>
            </div>

            <div class="profile-body">
                <% if (!successMsg.equals("")) { %>
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i>
                        <%= successMsg %>
                    </div>
                <% } %>

                <form method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Full Name</label>
                            <input type="text" name="name" value="<%= name %>" placeholder="Enter your full name" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-venus-mars"></i> Gender</label>
                            <input type="text" name="gender" value="<%= gender %>" placeholder="Male / Female / Other" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-phone-alt"></i> Contact Number</label>
                            <input type="text" name="contact" value="<%= contact %>" placeholder="10-digit mobile number" required>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-tint"></i> Blood Group</label>
                            <input type="text" name="bloodgrp" value="<%= bloodgrp %>" placeholder="A+, B+, O+, AB- etc." required>
                        </div>

                        <div class="form-group full-width">
                            <label><i class="fas fa-map-marker-alt"></i> Address</label>
                            <input type="text" name="address" value="<%= address %>" placeholder="Enter your complete address" required>
                        </div>
                    </div>

                    <div class="button-section">
                        <button type="submit" class="btn-update">
                            <i class="fas fa-save"></i> Update Profile
                        </button>
                        <a href="pdash.jsp" class="btn-back">
                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                        </a>
                    </div>
                </form>

                <div class="info-note">
                    <i class="fas fa-info-circle"></i>
                    Your information is secure and will only be used for medical purposes.
                </div>
            </div>
        </div>
    </div>
</body>
</html>