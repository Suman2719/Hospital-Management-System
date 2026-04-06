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
    <title>Admin Dashboard | Medix</title>
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
            background: linear-gradient(135deg, #2c3e50 0%, #1a1a2e 100%);
            border-radius: 28px;
            padding: 2rem;
            margin-bottom: 2rem;
            color: white;
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.3);
            animation: fadeInDown 0.6s ease-out;
            border: 1px solid rgba(255, 215, 0, 0.2);
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
            background: rgba(255, 215, 0, 0.2);
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
            background: rgba(255, 215, 0, 0.15);
            padding: 0.5rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 215, 0, 0.2);
        }

        .stat-badge i {
            margin-right: 0.5rem;
            color: #ffd700;
        }

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
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
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.2);
        }

        /* Card accent colors */
        .dashboard-card:nth-child(1) .card-icon {
            background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        }
        .dashboard-card:nth-child(1) .card-icon i {
            color: #0369a1;
        }

        .dashboard-card:nth-child(2) .card-icon {
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
        }
        .dashboard-card:nth-child(2) .card-icon i {
            color: #15803d;
        }

        .dashboard-card:nth-child(3) .card-icon {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
        }
        .dashboard-card:nth-child(3) .card-icon i {
            color: #b45309;
        }

        .dashboard-card:nth-child(4) .card-icon {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        }
        .dashboard-card:nth-child(4) .card-icon i {
            color: #dc2626;
        }

        .card-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.2rem;
        }

        .card-icon i {
            font-size: 2.5rem;
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
            font-size: 0.9rem;
            padding: 0.7rem 1.5rem;
            border-radius: 40px;
            transition: all 0.3s ease;
            background: #f1f5f9;
            color: #1e293b;
        }

        .dashboard-card:nth-child(1) .card-link:hover {
            background: #0369a1;
            color: white;
        }
        .dashboard-card:nth-child(2) .card-link:hover {
            background: #15803d;
            color: white;
        }
        .dashboard-card:nth-child(3) .card-link:hover {
            background: #b45309;
            color: white;
        }
        .dashboard-card:nth-child(4) .card-link:hover {
            background: #dc2626;
            color: white;
        }

        .card-link:hover {
            transform: translateX(5px);
        }

        .card-link i {
            font-size: 0.8rem;
            transition: transform 0.3s ease;
        }

        .card-link:hover i {
            transform: translateX(3px);
        }

        /* Quick Stats Section */
        .quick-stats {
            margin-top: 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .quick-stat-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            backdrop-filter: blur(10px);
        }

        .quick-stat-icon {
            width: 45px;
            height: 45px;
            background: rgba(255, 215, 0, 0.15);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quick-stat-icon i {
            font-size: 1.2rem;
            color: #ffd700;
        }

        .quick-stat-info h4 {
            font-size: 0.75rem;
            color: #64748b;
            margin-bottom: 0.2rem;
        }

        .quick-stat-info p {
            font-size: 0.9rem;
            font-weight: 600;
            color: #0f172a;
        }

        /* Responsive */
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
            
            .quick-stats {
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

        /* Admin badge */
        .admin-badge {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: rgba(255, 215, 0, 0.1);
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.7rem;
            color: #ffd700;
            border: 1px solid rgba(255, 215, 0, 0.3);
            backdrop-filter: blur(5px);
            z-index: 100;
        }

        .admin-badge i {
            margin-right: 0.3rem;
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
                    <i class="fas fa-user-shield"></i>
                    Welcome, Admin!
                </h1>
                <p>Manage doctors, appointments, and system settings from your central dashboard</p>
                <div class="stats-row">
                    <div class="stat-badge">
                        <i class="fas fa-chart-line"></i> System Overview
                    </div>
                    <div class="stat-badge">
                        <i class="fas fa-database"></i> Full Control Access
                    </div>
                    <div class="stat-badge">
                        <i class="fas fa-shield-alt"></i> Secure Admin Portal
                    </div>
                </div>
            </div>

            <!-- Dashboard Cards Grid -->
            <div class="dashboard-grid">
                <!-- Add Doctor Card -->
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h3>Add Doctor</h3>
                    <p>Register new physicians to the hospital. Add their specialization, contact details, and consultation fees.</p>
                    <a href="addoctor.jsp" class="card-link">
                        Add New Doctor <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <!-- View Doctors Card -->
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="fas fa-stethoscope"></i>
                    </div>
                    <h3>View Doctors</h3>
                    <p>Manage existing doctor profiles. Edit information, update fees, or remove doctors from the system.</p>
                    <a href="dview.jsp" class="card-link">
                        Manage Doctors <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <!-- View Appointments Card -->
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3>Appointments</h3>
                    <p>View all patient appointments across all doctors. Track status and monitor healthcare activity.</p>
                    <a href="pviewadmin.jsp" class="card-link">
                        View All Appointments <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <!-- Logout Card -->
                <div class="dashboard-card">
                    <div class="card-icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <h3>Logout</h3>
                    <p>Securely exit your admin session. Your dashboard will be locked until next login.</p>
                    <a href="alogout.jsp" class="card-link">
                        Logout <i class="fas fa-sign-out-alt"></i>
                    </a>
                </div>
            </div>

            <!-- Quick Stats / Info Section -->
            <div class="quick-stats">
                <div class="quick-stat-card">
                    <div class="quick-stat-icon">
                        <i class="fas fa-chart-simple"></i>
                    </div>
                    <div class="quick-stat-info">
                        <h4>System Status</h4>
                        <p>🟢 All Systems Operational</p>
                    </div>
                </div>
                <div class="quick-stat-card">
                    <div class="quick-stat-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="quick-stat-info">
                        <h4>Last Login</h4>
                        <p id="lastLogin">Today</p>
                    </div>
                </div>
                <div class="quick-stat-card">
                    <div class="quick-stat-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <div class="quick-stat-info">
                        <h4>Support</h4>
                        <p>admin@medix.com</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="admin-badge">
        <i class="fas fa-crown"></i> Administrator Access
    </div>

    <script>
        // Display current date and time
        const now = new Date();
        const dateOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const timeOptions = { hour: '2-digit', minute: '2-digit' };
        document.getElementById('lastLogin').innerHTML = now.toLocaleDateString('en-US', dateOptions) + ' at ' + now.toLocaleTimeString('en-US', timeOptions);
    </script>
</body>
</html>