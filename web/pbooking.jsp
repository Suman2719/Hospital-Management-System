<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Session check
    String patientEmail = (String) session.getAttribute("patientEmail");
    if (patientEmail == null) {
        response.sendRedirect("patientlogin.jsp");
        return;
    }
    patientEmail = patientEmail.trim().toLowerCase();

    String specialization = request.getParameter("specialization");
    String bookedMsg = "";

    // Database URL & credentials
    String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
    String dbUser = "system";
    String dbPass = "SUMAN";

    // Handle booking if form submitted (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String doctorId = request.getParameter("doctorId");
        String doctorName = request.getParameter("doctorName");
        String apptDate = request.getParameter("appt_date");
        String apptTime = request.getParameter("appt_time");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass)) {

                // Check if patient exists
                String checkPatient = "SELECT COUNT(*) FROM preg WHERE email = ?";
                try (PreparedStatement psCheck = con.prepareStatement(checkPatient)) {
                    psCheck.setString(1, patientEmail);
                    try (ResultSet rsCheck = psCheck.executeQuery()) {
                        rsCheck.next();
                        int count = rsCheck.getInt(1);
                        if (count == 0) {
                            bookedMsg = "❌ Error: Patient email not found in database!";
                        } else {
                            // Insert appointment
                            String insert = "INSERT INTO appointment(id, patient_email, doctor_id, appt_date, appt_time, status) "
                                          + "VALUES (appt_seq.nextval, ?, ?, ?, ?, ?)";
                            try (PreparedStatement psInsert = con.prepareStatement(insert)) {
                                psInsert.setString(1, patientEmail);
                                psInsert.setString(2, doctorId.trim());
                                psInsert.setDate(3, java.sql.Date.valueOf(apptDate));
                                psInsert.setString(4, apptTime.trim());
                                psInsert.setString(5, "Booked");

                                int rows = psInsert.executeUpdate();
                                if (rows > 0) {
                                    bookedMsg = "✅ Appointment booked successfully with Dr. "
                                                + doctorName + " on " + apptDate + " at " + apptTime;
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            bookedMsg = "Error booking appointment: " + e.getMessage();
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment | Medix</title>
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
        .booking-container {
            max-width: 1200px;
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
            max-width: 600px;
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

        /* Specialization Selector */
        .specialization-card {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .specialization-card label {
            font-size: 1rem;
            font-weight: 600;
            color: #334155;
            margin-right: 1rem;
        }

        .specialization-card select {
            padding: 0.75rem 1.5rem;
            border: 2px solid #e2e8f0;
            border-radius: 40px;
            font-size: 0.9rem;
            font-family: 'Inter', sans-serif;
            background: #f8fafc;
            cursor: pointer;
            min-width: 220px;
            transition: all 0.3s ease;
        }

        .specialization-card select:focus {
            outline: none;
            border-color: #1a6d5e;
            box-shadow: 0 0 0 3px rgba(26, 109, 94, 0.1);
        }

        /* Section Title */
        .section-title {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e2e8f0;
        }

        .section-title i {
            font-size: 1.5rem;
            color: #1a6d5e;
        }

        .section-title h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: #0f172a;
        }

        /* Doctors Grid */
        .doctors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            margin-top: 1rem;
        }

        /* Doctor Card */
        .doctor-card {
            background: white;
            border-radius: 24px;
            padding: 1.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid rgba(0, 0, 0, 0.03);
        }

        .doctor-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.15);
        }

        .doctor-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .doctor-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #e0f2fe 0%, #ccfbf1 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .doctor-avatar i {
            font-size: 1.8rem;
            color: #1a6d5e;
        }

        .doctor-info h4 {
            font-size: 1.1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.25rem;
        }

        .doctor-info .degree {
            font-size: 0.8rem;
            color: #64748b;
        }

        .doctor-details {
            margin-bottom: 1rem;
            padding: 0.5rem 0;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            font-size: 0.85rem;
        }

        .detail-item .label {
            color: #64748b;
            font-weight: 500;
        }

        .detail-item .value {
            font-weight: 600;
            color: #1a6d5e;
        }

        .booking-form {
            margin-top: 1rem;
        }

        .datetime-group {
            display: flex;
            gap: 0.8rem;
            margin-bottom: 1rem;
        }

        .datetime-group input {
            flex: 1;
            padding: 0.7rem;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            font-size: 0.85rem;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
        }

        .datetime-group input:focus {
            outline: none;
            border-color: #1a6d5e;
            box-shadow: 0 0 0 3px rgba(26, 109, 94, 0.1);
        }

        .book-btn {
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .book-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 109, 94, 0.4);
            background: linear-gradient(135deg, #145c4f 0%, #0f4c42 100%);
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

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 24px;
            color: #64748b;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .booking-container {
                margin: 1rem auto;
            }
            
            .doctors-grid {
                grid-template-columns: 1fr;
            }
            
            .datetime-group {
                flex-direction: column;
            }
            
            .specialization-card select {
                width: 100%;
                margin-top: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="booking-container">
        <div class="page-header">
            <h2>📅 Book an Appointment</h2>
            <p>Schedule a consultation with our expert doctors</p>
        </div>

        <% if (!bookedMsg.isEmpty()) { %>
            <div class="message-alert <%= bookedMsg.startsWith("✅") ? "success" : "error" %>">
                <i class="<%= bookedMsg.startsWith("✅") ? "fas fa-check-circle" : "fas fa-exclamation-triangle" %>"></i>
                <%= bookedMsg %>
            </div>
        <% } %>

        <!-- Step 1: Choose Specialization -->
        <div class="specialization-card">
            <form method="get" action="pbooking.jsp">
                <label><i class="fas fa-stethoscope"></i> Select Specialization:</label>
                <select name="specialization" required onchange="this.form.submit()">
                    <option value="">-- Choose a specialization --</option>
                    <option value="Cardiologist" <%= "Cardiologist".equals(specialization) ? "selected" : "" %>>❤️ Cardiologist</option>
                    <option value="Gynecologist" <%= "Gynecologist".equals(specialization) ? "selected" : "" %>>👩‍⚕️ Gynecologist</option>
                    <option value="Dentist" <%= "Dentist".equals(specialization) ? "selected" : "" %>>🦷 Dentist</option>
                    <option value="Orthopedic" <%= "Orthopedic".equals(specialization) ? "selected" : "" %>>🦴 Orthopedic</option>
                    <option value="Neurologist" <%= "Neurologist".equals(specialization) ? "selected" : "" %>>🧠 Neurologist</option>
                    <option value="General Physician" <%= "General Physician".equals(specialization) ? "selected" : "" %>>🏥 General Physician</option>
                </select>
            </form>
        </div>

        <%
        if (specialization != null && !specialization.trim().isEmpty()) {
            try (Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                String q1 = "SELECT * FROM doctor WHERE specialization=?";
                try (PreparedStatement ps = con.prepareStatement(q1)) {
                    ps.setString(1, specialization);
                    try (ResultSet rs = ps.executeQuery()) {
                        
                        boolean hasDoctors = false;
        %>
        
        <div class="section-title">
            <i class="fas fa-user-md"></i>
            <h3>Available Doctors - <%= specialization %></h3>
        </div>

        <div class="doctors-grid">
        <%
                        while (rs.next()) {
                            hasDoctors = true;
        %>
            <div class="doctor-card">
                <div class="doctor-header">
                    <div class="doctor-avatar">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <div class="doctor-info">
                        <h4>Dr. <%= rs.getString("name") %></h4>
                        <span class="degree"><%= rs.getString("degree") %></span>
                    </div>
                </div>
                
                <div class="doctor-details">
                    <div class="detail-item">
                        <span class="label"><i class="fas fa-envelope"></i> Email:</span>
                        <span class="value"><%= rs.getString("email") %></span>
                    </div>
                    <div class="detail-item">
                        <span class="label"><i class="fas fa-rupee-sign"></i> Consultation Fee:</span>
                        <span class="value">₹<%= rs.getString("fees") %></span>
                    </div>
                </div>

                <form method="post" action="pbooking.jsp" class="booking-form">
                    <input type="hidden" name="doctorId" value="<%= rs.getString("id") %>">
                    <input type="hidden" name="doctorName" value="<%= rs.getString("name") %>">
                    <div class="datetime-group">
                        <input type="date" name="appt_date" required>
                        <input type="time" name="appt_time" required>
                    </div>
                    <button type="submit" class="book-btn">
                        <i class="fas fa-calendar-check"></i> Book Appointment
                    </button>
                </form>
            </div>
        <%
                        }
                        
                        if (!hasDoctors) {
        %>
            <div class="empty-state">
                <i class="fas fa-frown"></i>
                <p>No doctors available in this specialization at the moment.</p>
                <p style="font-size: 0.85rem; margin-top: 0.5rem;">Please check back later or try another specialization.</p>
            </div>
        <%
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<div class='message-alert error'><i class='fas fa-exclamation-triangle'></i> Error loading doctors: " + e.getMessage() + "</div>");
            }
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