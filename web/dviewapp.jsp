<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    if (session.getAttribute("doctorEmail") == null) {
        response.sendRedirect("dlogin.jsp");
        return;
    }
    String doctorEmail = ((String) session.getAttribute("doctorEmail")).trim().toLowerCase();
    String doctorName = (String) session.getAttribute("doctorName");
    String msg = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String apptId = request.getParameter("apptId");
        String newStatus = request.getParameter("status");

        if (apptId != null && newStatus != null) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

                String update = "UPDATE appointment SET status=? WHERE id=?";
                PreparedStatement ps = con.prepareStatement(update);
                ps.setString(1, newStatus);
                ps.setInt(2, Integer.parseInt(apptId));

                int rows = ps.executeUpdate();
                msg = (rows > 0) ? "✅ Appointment status updated successfully!" : "❌ Failed to update status.";

                ps.close();
                con.close();
            } catch (Exception e) {
                msg = "Error updating appointment: " + e.getMessage();
                e.printStackTrace();
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Appointments | Medix</title>
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

        /* Main Container */
        .appointments-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 1rem;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 2rem;
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

        .page-header h2 {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #64748b;
            font-size: 0.9rem;
        }

        .doctor-badge {
            display: inline-block;
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            padding: 0.5rem 1.2rem;
            border-radius: 40px;
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }

        /* Message Alert */
        .message-alert {
            max-width: 500px;
            margin: 0 auto 1.5rem;
            padding: 1rem;
            border-radius: 16px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
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

        .message-alert.success {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #065f46;
        }

        .message-alert.error {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
        }

        .message-alert i {
            font-size: 1.2rem;
        }

        /* Stats Row */
        .stats-row {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            padding: 1rem 1.5rem;
            border-radius: 40px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .stat-card i {
            font-size: 1.2rem;
        }

        .stat-card .stat-label {
            font-size: 0.8rem;
            color: #64748b;
        }

        .stat-card .stat-number {
            font-size: 1.3rem;
            font-weight: 700;
            color: #0f172a;
        }

        /* Appointments Grid */
        .appointments-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 1.5rem;
            margin-top: 1rem;
        }

        /* Appointment Card */
        .appointment-card {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.03);
            position: relative;
        }

        .appointment-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.15);
        }

        /* Status Badge */
        .status-badge {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            padding: 0.3rem 0.8rem;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .status-badge.booked {
            background: #dbeafe;
            color: #1e40af;
        }

        .status-badge.completed {
            background: #d1fae5;
            color: #065f46;
        }

        .status-badge.cancelled {
            background: #fee2e2;
            color: #991b1b;
        }

        /* Appointment Header */
        .appointment-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.2rem;
        }

        .appointment-id {
            background: #f1f5f9;
            padding: 0.3rem 0.8rem;
            border-radius: 40px;
            font-size: 0.75rem;
            font-weight: 600;
            color: #1a6d5e;
        }

        /* Patient Info */
        .patient-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .patient-avatar {
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, #e0f2fe 0%, #ccfbf1 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .patient-avatar i {
            font-size: 1.6rem;
            color: #1a6d5e;
        }

        .patient-details h4 {
            font-size: 1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.25rem;
        }

        .patient-details .patient-contact {
            font-size: 0.75rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        /* Appointment Details */
        .appointment-details {
            margin-bottom: 1.2rem;
        }

        .detail-row {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.5rem 0;
            font-size: 0.85rem;
        }

        .detail-row i {
            width: 20px;
            color: #1a6d5e;
        }

        .detail-row .label {
            color: #64748b;
            width: 70px;
        }

        .detail-row .value {
            font-weight: 500;
            color: #0f172a;
        }

        /* Update Form */
        .update-form {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #e2e8f0;
            display: flex;
            gap: 0.8rem;
            align-items: center;
        }

        .update-form select {
            flex: 2;
            padding: 0.7rem;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            font-size: 0.85rem;
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .update-form select:focus {
            outline: none;
            border-color: #1a6d5e;
            box-shadow: 0 0 0 3px rgba(26, 109, 94, 0.1);
        }

        .update-btn {
            flex: 1;
            padding: 0.7rem;
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            border: none;
            border-radius: 16px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .update-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(26, 109, 94, 0.3);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem;
            background: white;
            border-radius: 24px;
            color: #64748b;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: #0f172a;
        }

        /* Back Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 2rem;
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

        /* Responsive */
        @media (max-width: 768px) {
            .appointments-container {
                margin: 1rem auto;
            }
            
            .appointments-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-row {
                flex-direction: column;
                align-items: stretch;
            }
            
            .update-form {
                flex-direction: column;
            }
            
            .update-form select,
            .update-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="appointments-container">
        <div class="page-header">
            <h2><i class="fas fa-calendar-check"></i> Manage Appointments</h2>
            <p>View and update patient appointment status</p>
            <div class="doctor-badge">
                <i class="fas fa-user-md"></i> Dr. <%= doctorName %>
            </div>
        </div>

        <% if (!msg.isEmpty()) { %>
            <div class="message-alert <%= msg.startsWith("✅") ? "success" : "error" %>">
                <i class="<%= msg.startsWith("✅") ? "fas fa-check-circle" : "fas fa-exclamation-triangle" %>"></i>
                <%= msg %>
            </div>
        <% } %>

        <%
            int bookedCount = 0;
            int completedCount = 0;
            int cancelledCount = 0;
            
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

                String q1 = "SELECT id FROM doctor WHERE email=?";
                PreparedStatement ps1 = con.prepareStatement(q1);
                ps1.setString(1, doctorEmail);
                ResultSet rs1 = ps1.executeQuery();
                String doctorId = null;
                if (rs1.next()) {
                    doctorId = rs1.getString("id");
                }
                rs1.close();
                ps1.close();

                if (doctorId != null) {
                    String q2 = "SELECT a.id, a.patient_email, a.appt_date, a.appt_time, a.status, " +
                                "p.name as patient_name, p.cno as patient_contact " +
                                "FROM appointment a " +
                                "JOIN preg p ON a.patient_email = p.email " +
                                "WHERE a.doctor_id=? ORDER BY a.appt_date DESC, a.appt_time DESC";
                    PreparedStatement ps2 = con.prepareStatement(q2);
                    ps2.setString(1, doctorId);
                    ResultSet rs2 = ps2.executeQuery();
                    
                    boolean hasAppointments = false;
        %>

        <div class="stats-row">
            <div class="stat-card">
                <i class="fas fa-calendar-alt" style="color: #3b82f6;"></i>
                <div>
                    <div class="stat-label">Total</div>
                    <div class="stat-number" id="totalCount">0</div>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock" style="color: #f59e0b;"></i>
                <div>
                    <div class="stat-label">Booked</div>
                    <div class="stat-number" id="bookedCount">0</div>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-check-circle" style="color: #10b981;"></i>
                <div>
                    <div class="stat-label">Completed</div>
                    <div class="stat-number" id="completedCount">0</div>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-times-circle" style="color: #ef4444;"></i>
                <div>
                    <div class="stat-label">Cancelled</div>
                    <div class="stat-number" id="cancelledCount">0</div>
                </div>
            </div>
        </div>

        <div class="appointments-grid">
        <%
                    while (rs2.next()) {
                        hasAppointments = true;
                        String status = rs2.getString("status");
                        String statusClass = status.toLowerCase();
                        
                        // Count for stats
                        if ("Booked".equalsIgnoreCase(status)) bookedCount++;
                        else if ("Completed".equalsIgnoreCase(status)) completedCount++;
                        else if ("Cancelled".equalsIgnoreCase(status)) cancelledCount++;
        %>
            <div class="appointment-card">
                <div class="status-badge <%= statusClass %>">
                    <i class="<%= statusClass.equals("booked") ? "fas fa-clock" : (statusClass.equals("completed") ? "fas fa-check-circle" : "fas fa-times-circle") %>"></i>
                    <%= status %>
                </div>
                
                <div class="appointment-header">
                    <span class="appointment-id">
                        <i class="fas fa-hashtag"></i> ID: <%= rs2.getInt("id") %>
                    </span>
                </div>
                
                <div class="patient-info">
                    <div class="patient-avatar">
                        <i class="fas fa-user-injured"></i>
                    </div>
                    <div class="patient-details">
                        <h4><%= rs2.getString("patient_name") %></h4>
                        <span class="patient-contact">
                            <i class="fas fa-envelope"></i> <%= rs2.getString("patient_email") %>
                        </span>
                        <span class="patient-contact">
                            <i class="fas fa-phone"></i> <%= rs2.getString("patient_contact") %>
                        </span>
                    </div>
                </div>
                
                <div class="appointment-details">
                    <div class="detail-row">
                        <i class="fas fa-calendar-day"></i>
                        <span class="label">Date:</span>
                        <span class="value"><%= rs2.getDate("appt_date") %></span>
                    </div>
                    <div class="detail-row">
                        <i class="fas fa-clock"></i>
                        <span class="label">Time:</span>
                        <span class="value"><%= rs2.getString("appt_time") %></span>
                    </div>
                </div>

                <form method="post" action="dviewapp.jsp" class="update-form">
                    <input type="hidden" name="apptId" value="<%= rs2.getInt("id") %>">
                    <select name="status">
                        <option value="Booked" <%= "Booked".equals(status) ? "selected" : "" %>>📋 Booked</option>
                        <option value="Completed" <%= "Completed".equals(status) ? "selected" : "" %>>✅ Completed</option>
                        <option value="Cancelled" <%= "Cancelled".equals(status) ? "selected" : "" %>>❌ Cancelled</option>
                    </select>
                    <button type="submit" class="update-btn">
                        <i class="fas fa-save"></i> Update
                    </button>
                </form>
            </div>
        <%
                    }
                    
                    if (!hasAppointments) {
        %>
            <div class="empty-state" style="grid-column: 1/-1;">
                <i class="fas fa-calendar-times"></i>
                <h3>No Appointments Found</h3>
                <p>You don't have any scheduled appointments at the moment.</p>
                <p style="font-size: 0.85rem; margin-top: 0.5rem;">Patients will be able to book appointments with you soon.</p>
            </div>
        <%
                    }
                    rs2.close();
                    ps2.close();
                    con.close();
                } else {
                    out.println("<div class='message-alert error'><i class='fas fa-exclamation-triangle'></i> Doctor ID not found. Please contact admin.</div>");
                }
            } catch (Exception e) {
                out.println("<div class='message-alert error'><i class='fas fa-exclamation-triangle'></i> Error: " + e.getMessage() + "</div>");
                e.printStackTrace();
            }
        %>
        </div>
        
        <script>
            // Update stats counts
            document.getElementById('totalCount').innerText = <%= bookedCount + completedCount + cancelledCount %>;
            document.getElementById('bookedCount').innerText = <%= bookedCount %>;
            document.getElementById('completedCount').innerText = <%= completedCount %>;
            document.getElementById('cancelledCount').innerText = <%= cancelledCount %>;
        </script>

        <div style="text-align: center;">
            <a href="ddash.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>