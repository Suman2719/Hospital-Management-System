<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*" %>

<%
    if (session.getAttribute("doctorEmail") == null) {
        response.sendRedirect("dlogin.jsp");
        return;
    }
    String doctorName = (String) session.getAttribute("doctorName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard | Medix</title>
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
            background: linear-gradient(135deg, #e8f0f5 0%, #d4e4ed 100%);
            min-height: 100vh;
            color: #1e293b;
        }

        /* Dashboard Wrapper */
        .dashboard-wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 2rem;
            margin-top: 1rem;
        }

        /* Welcome Header */
        .welcome-header {
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            border-radius: 28px;
            padding: 2rem;
            margin-bottom: 2rem;
            color: white;
            box-shadow: 0 10px 30px -10px rgba(26, 109, 94, 0.3);
            animation: fadeInDown 0.6s ease-out;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .welcome-header h1 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            flex-wrap: wrap;
        }

        .welcome-header h1 i {
            font-size: 2rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 0.8rem;
            border-radius: 50%;
        }

        .welcome-header p {
            opacity: 0.9;
            font-size: 0.95rem;
        }

        .stats-row {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            flex-wrap: wrap;
        }

        .stat-badge {
            background: rgba(255, 255, 255, 0.15);
            padding: 0.5rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            backdrop-filter: blur(10px);
        }

        .stat-badge i {
            margin-right: 0.5rem;
        }

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 1.8rem;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Dashboard Cards */
        .dashboard-card {
            background: white;
            border-radius: 24px;
            padding: 2rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.03);
            position: relative;
            overflow: hidden;
            text-align: center;
        }

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.15);
        }

        .card-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #e0f2fe 0%, #ccfbf1 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.2rem;
        }

        .card-icon i {
            font-size: 2.5rem;
            color: #1a6d5e;
        }

        .dashboard-card h3 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }

        .dashboard-card p {
            color: #64748b;
            font-size: 0.85rem;
            line-height: 1.5;
            margin-bottom: 1.5rem;
        }

        .card-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            padding: 0.8rem 1.8rem;
            border-radius: 40px;
            transition: all 0.3s ease;
            background: #f1f5f9;
            color: #1a6d5e;
        }

        .card-link:hover {
            background: #1a6d5e;
            color: white;
            transform: translateX(5px);
        }

        .card-link i {
            font-size: 0.85rem;
            transition: transform 0.3s ease;
        }

        .card-link:hover i {
            transform: translateX(3px);
        }

        /* Logout card special styling */
        .dashboard-card:last-child .card-icon {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        }

        .dashboard-card:last-child .card-icon i {
            color: #dc2626;
        }

        .dashboard-card:last-child .card-link {
            background: #fef2f2;
            color: #dc2626;
        }

        .dashboard-card:last-child .card-link:hover {
            background: #dc2626;
            color: white;
        }

        /* Quick Info Section */
        .info-section {
            margin-top: 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .info-card {
            background: white;
            border-radius: 20px;
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .info-icon {
            width: 45px;
            height: 45px;
            background: #e0f2fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .info-icon i {
            font-size: 1.2rem;
            color: #1a6d5e;
        }

        .info-text h4 {
            font-size: 0.8rem;
            color: #64748b;
            margin-bottom: 0.2rem;
        }

        .info-text p {
            font-size: 0.9rem;
            font-weight: 600;
            color: #0f172a;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-content {
                padding: 1.5rem;
            }
            
            .welcome-header {
                padding: 1.5rem;
            }
            
            .welcome-header h1 {
                font-size: 1.4rem;
                flex-direction: column;
                text-align: center;
            }
            
            .dashboard-grid {
                gap: 1.2rem;
            }
            
            .dashboard-card {
                padding: 1.5rem;
            }
            
            .info-section {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .main-content {
                padding: 1rem;
            }
            
            .stats-row {
                flex-direction: column;
            }
            
            .dashboard-card h3 {
                font-size: 1.2rem;
            }
        }

        /* Current Date Display */
        .current-date {
            font-size: 0.85rem;
            opacity: 0.8;
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <%@ include file="navbar.jsp" %>
        
        <div class="main-content">
            <!-- Welcome Header -->
            <div class="welcome-header">
                <h1>
                    <i class="fas fa-user-md"></i>
                    Welcome, Dr. <%= doctorName %>
                </h1>
                <p>Manage your appointments and patient consultations</p>
                <div class="stats-row">
                    <div class="stat-badge">
                        <i class="fas fa-calendar-check"></i> Today's Schedule
                    </div>
                    <div class="stat-badge">
                        <i class="fas fa-clock"></i> 9:00 AM - 6:00 PM
                    </div>
                    <div class="stat-badge">
                        <i class="fas fa-shield-alt"></i> Secure Portal
                    </div>
                </div>
                <div class="current-date" id="currentDate"></div>
            </div>

            <!-- Dashboard Cards Grid -->
            <div class="dashboard-grid">
                <!-- View Appointments Card -->
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <h3>Appointments</h3>
                    <p>View all your scheduled appointments. Check patient details, update status, and manage your daily schedule.</p>
                    <a href="dviewapp.jsp" class="card-link">
                        View Appointments <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <!-- Logout Card -->
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <h3>Logout</h3>
                    <p>Securely exit your doctor portal. Your session will be closed immediately.</p>
                    <a href="dlogout.jsp" class="card-link">
                        Logout <i class="fas fa-sign-out-alt"></i>
                    </a>
                </div>
            </div>

            <!-- Quick Info Section -->
            <div class="info-section">
                <div class="info-card">
                    <div class="info-icon">
                        <i class="fas fa-stethoscope"></i>
                    </div>
                    <div class="info-text">
                        <h4>Department</h4>
                        <p>General Medicine</p>
                    </div>
                </div>
                <div class="info-card">
                    <div class="info-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="info-text">
                        <h4>Consultation Hours</h4>
                        <p>Mon - Sat | 9AM - 6PM</p>
                    </div>
                </div>
                <div class="info-card">
                    <div class="info-icon">
                        <i class="fas fa-phone-alt"></i>
                    </div>
                    <div class="info-text">
                        <h4>Support</h4>
                        <p>help@medix.com | 1800-MEDIX</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Display current date
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const today = new Date();
        document.getElementById('currentDate').innerHTML = '<i class="fas fa-calendar-day"></i> ' + today.toLocaleDateString('en-US', options);
    </script>
</body>
</html>