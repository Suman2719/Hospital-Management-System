<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Session check
    if (session.getAttribute("patientEmail") == null) {
        response.sendRedirect("patientlogin.jsp");
        return;
    }
    String patientEmail = ((String) session.getAttribute("patientEmail")).trim().toLowerCase();
    String cancelMsg = "";

    // Handle cancel request
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("cancelId") != null) {
        String cancelId = request.getParameter("cancelId");
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

            String update = "UPDATE appointment SET status='Cancelled' " +
                            "WHERE id=? AND patient_email=?";
            PreparedStatement psCancel = con.prepareStatement(update);
            psCancel.setInt(1, Integer.parseInt(cancelId));
            psCancel.setString(2, patientEmail);

            int rows = psCancel.executeUpdate();
            if (rows > 0) {
                cancelMsg = "✅ Appointment cancelled successfully.";
            } else {
                cancelMsg = "⚠️ Unable to cancel appointment.";
            }
            psCancel.close();
            con.close();
        } catch (Exception e) {
            cancelMsg = "Error cancelling appointment: " + e.getMessage();
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Appointments | Medix</title>
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
        .appointments-container {
            max-width: 1300px;
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
            color: #1a6d5e;
        }

        .stat-card span {
            font-weight: 600;
            color: #0f172a;
        }

        /* Appointments Grid */
        .appointments-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
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
            overflow: hidden;
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

        /* Doctor Info */
        .doctor-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.2rem;
        }

        .doctor-avatar {
            width: 65px;
            height: 65px;
            background: linear-gradient(135deg, #e0f2fe 0%, #ccfbf1 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .doctor-avatar i {
            font-size: 2rem;
            color: #1a6d5e;
        }

        .doctor-details h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.25rem;
        }

        .doctor-details .specialization {
            font-size: 0.8rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        /* Appointment Details */
        .appointment-details {
            margin-bottom: 1.2rem;
            padding: 0.8rem 0;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            font-size: 0.85rem;
        }

        .detail-row .label {
            color: #64748b;
            font-weight: 500;
        }

        .detail-row .value {
            font-weight: 600;
            color: #1a6d5e;
        }

        /* Cancel Button */
        .cancel-btn {
            width: 100%;
            padding: 0.75rem;
            background: #fee2e2;
            color: #dc2626;
            border: none;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .cancel-btn:hover {
            background: #dc2626;
            color: white;
            transform: translateY(-2px);
        }

        .cancelled-badge {
            width: 100%;
            padding: 0.75rem;
            background: #f1f5f9;
            color: #94a3b8;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
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
            
            .stat-card {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="appointments-container">
        <div class="page-header">
            <h2>📋 My Appointments</h2>
            <p>View and manage your scheduled consultations</p>
        </div>

        <% if (!cancelMsg.isEmpty()) { %>
            <div class="message-alert <%= cancelMsg.startsWith("✅") ? "success" : "error" %>">
                <i class="<%= cancelMsg.startsWith("✅") ? "fas fa-check-circle" : "fas fa-exclamation-triangle" %>"></i>
                <%= cancelMsg %>
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

                String query = "SELECT a.id, a.appt_date, a.appt_time, a.status, " +
                               "d.name AS doctor_name, d.specialization, d.fees " +
                               "FROM appointment a " +
                               "JOIN doctor d ON a.doctor_id = d.id " +
                               "WHERE a.patient_email = ? " +
                               "ORDER BY a.appt_date DESC, a.appt_time DESC";

                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, patientEmail);
                ResultSet rs = ps.executeQuery();

                boolean hasAppointments = false;
        %>

        <div class="stats-row">
            <div class="stat-card">
                <i class="fas fa-calendar-check"></i>
                <span>Total Appointments: <span id="totalCount">0</span></span>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock"></i>
                <span>Upcoming: <span id="bookedCount">0</span></span>
            </div>
            <div class="stat-card">
                <i class="fas fa-check-circle"></i>
                <span>Completed: <span id="completedCount">0</span></span>
            </div>
            <div class="stat-card">
                <i class="fas fa-times-circle"></i>
                <span>Cancelled: <span id="cancelledCount">0</span></span>
            </div>
        </div>

        <div class="appointments-grid" id="appointmentsGrid">
        <%
            while (rs.next()) {
                hasAppointments = true;
                String status = rs.getString("status");
                String statusClass = status.toLowerCase();
                
                // Count for stats
                if ("Booked".equalsIgnoreCase(status)) bookedCount++;
                else if ("Completed".equalsIgnoreCase(status)) completedCount++;
                else if ("Cancelled".equalsIgnoreCase(status)) cancelledCount++;
        %>
            <div class="appointment-card" data-status="<%= statusClass %>">
                <div class="status-badge <%= statusClass %>">
                    <i class="<%= statusClass.equals("booked") ? "fas fa-clock" : (statusClass.equals("completed") ? "fas fa-check-circle" : "fas fa-times-circle") %>"></i>
                    <%= status %>
                </div>
                
                <div class="doctor-info">
                    <div class="doctor-avatar">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <div class="doctor-details">
                        <h3>Dr. <%= rs.getString("doctor_name") %></h3>
                        <span class="specialization">
                            <i class="fas fa-stethoscope"></i> <%= rs.getString("specialization") %>
                        </span>
                    </div>
                </div>
                
                <div class="appointment-details">
                    <div class="detail-row">
                        <span class="label"><i class="fas fa-calendar-alt"></i> Appointment ID:</span>
                        <span class="value">#<%= rs.getInt("id") %></span>
                    </div>
                    <div class="detail-row">
                        <span class="label"><i class="fas fa-calendar-day"></i> Date:</span>
                        <span class="value"><%= rs.getDate("appt_date") %></span>
                    </div>
                    <div class="detail-row">
                        <span class="label"><i class="fas fa-clock"></i> Time:</span>
                        <span class="value"><%= rs.getString("appt_time") %></span>
                    </div>
                    <div class="detail-row">
                        <span class="label"><i class="fas fa-rupee-sign"></i> Consultation Fee:</span>
                        <span class="value">₹<%= rs.getString("fees") %></span>
                    </div>
                </div>

                <% if (!"Cancelled".equalsIgnoreCase(status)) { %>
                    <form method="post" action="pviewapp.jsp">
                        <input type="hidden" name="cancelId" value="<%= rs.getInt("id") %>">
                        <button type="submit" class="cancel-btn" onclick="return confirm('⚠️ Are you sure you want to cancel this appointment?\n\nThis action cannot be undone.');">
                            <i class="fas fa-ban"></i> Cancel Appointment
                        </button>
                    </form>
                <% } else { %>
                    <div class="cancelled-badge">
                        <i class="fas fa-ban"></i> Appointment Cancelled
                    </div>
                <% } %>
            </div>
        <%
            }
            
            if (!hasAppointments) {
        %>
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <h3>No Appointments Found</h3>
                <p>You haven't booked any appointments yet.</p>
                <p style="font-size: 0.85rem; margin-top: 0.5rem;">Click the button below to book your first appointment.</p>
            </div>
        <%
            }
            rs.close();
            ps.close();
            con.close();
        %>
        </div>
        
        <script>
            // Update stats counts
            document.getElementById('totalCount').innerText = <%= bookedCount + completedCount + cancelledCount %>;
            document.getElementById('bookedCount').innerText = <%= bookedCount %>;
            document.getElementById('completedCount').innerText = <%= completedCount %>;
            document.getElementById('cancelledCount').innerText = <%= cancelledCount %>;
        </script>
        
        <%
            } catch (Exception e) {
                out.println("<div class='message-alert error'><i class='fas fa-exclamation-triangle'></i> Error fetching appointments: " + e.getMessage() + "</div>");
                e.printStackTrace();
            }
        %>

        <div style="text-align: center;">
            <a href="pdash.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>