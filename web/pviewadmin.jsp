<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>All Appointments | Admin Dashboard</title>
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
            background: linear-gradient(135deg, #ffd700 0%, #f59e0b 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #94a3b8;
            font-size: 0.9rem;
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
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1rem 1.5rem;
            border-radius: 40px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            border: 1px solid rgba(255, 215, 0, 0.2);
        }

        .stat-card i {
            font-size: 1.2rem;
            color: #ffd700;
        }

        .stat-card .stat-number {
            font-size: 1.3rem;
            font-weight: 700;
            color: white;
        }

        .stat-card .stat-label {
            font-size: 0.8rem;
            color: #94a3b8;
        }

        /* Filter Bar */
        .filter-bar {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .filter-select, .search-input {
            padding: 0.75rem 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 40px;
            font-size: 0.85rem;
            font-family: 'Inter', sans-serif;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-select option {
            background: #1a1a2e;
            color: white;
        }

        .filter-select:focus, .search-input:focus {
            outline: none;
            border-color: #ffd700;
            background: rgba(255, 255, 255, 0.15);
        }

        .search-input {
            min-width: 250px;
        }

        .search-input::placeholder {
            color: #94a3b8;
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
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .appointment-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.25);
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
            justify-content: space-between;
            margin-bottom: 1.2rem;
            padding-bottom: 0.8rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .appointment-id {
            background: #f1f5f9;
            padding: 0.3rem 0.8rem;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 600;
            color: #1a6d5e;
        }

        /* Patient & Doctor Sections */
        .section {
            margin-bottom: 1rem;
        }

        .section-title {
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #64748b;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .info-row {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.4rem 0;
            font-size: 0.85rem;
        }

        .info-row i {
            width: 20px;
            color: #1a6d5e;
        }

        .info-row .label {
            color: #64748b;
            width: 45px;
        }

        .info-row .value {
            font-weight: 500;
            color: #0f172a;
            flex: 1;
        }

        .doctor-name {
            font-weight: 700;
            color: #1a6d5e;
        }

        /* Date & Time Row */
        .datetime-row {
            display: flex;
            gap: 1rem;
            margin-top: 0.8rem;
            padding-top: 0.8rem;
            border-top: 1px solid #e2e8f0;
        }

        .datetime-item {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.8rem;
        }

        .datetime-item i {
            color: #f59e0b;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem;
            background: white;
            border-radius: 24px;
            color: #64748b;
            grid-column: 1/-1;
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
            background: rgba(255, 255, 255, 0.1);
            color: #ffd700;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 215, 0, 0.3);
        }

        .back-link:hover {
            background: #ffd700;
            color: #1a1a2e;
            transform: translateX(-5px);
        }

        /* No results */
        .no-results {
            text-align: center;
            padding: 2rem;
            background: white;
            border-radius: 24px;
            color: #64748b;
            grid-column: 1/-1;
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
            
            .filter-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-input {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="appointments-container">
        <div class="page-header">
            <h2><i class="fas fa-calendar-alt"></i> All Patient Appointments</h2>
            <p>Monitor and manage all appointments across the hospital</p>
        </div>

        <%
            int totalCount = 0;
            int bookedCount = 0;
            int completedCount = 0;
            int cancelledCount = 0;
            
            // Store appointments data for JavaScript filtering
            StringBuilder appointmentsJson = new StringBuilder();
            appointmentsJson.append("[");
            
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

                String q = "SELECT a.id AS appt_id, p.name AS patient_name, p.email AS patient_email, " +
                           "d.name AS doctor_name, d.specialization AS doctor_specialization, " +
                           "a.appt_date, a.appt_time, a.status " +
                           "FROM appointment a " +
                           "JOIN preg p ON a.patient_email = p.email " +
                           "JOIN doctor d ON a.doctor_id = d.id " +
                           "ORDER BY a.appt_date DESC, a.appt_time DESC";

                PreparedStatement ps = con.prepareStatement(q);
                ResultSet rs = ps.executeQuery();

                boolean hasAppointments = false;
        %>

        <div class="stats-row" id="statsRow">
            <div class="stat-card">
                <i class="fas fa-calendar-check"></i>
                <div>
                    <div class="stat-number" id="totalCount">0</div>
                    <div class="stat-label">Total Appointments</div>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-clock"></i>
                <div>
                    <div class="stat-number" id="bookedCount">0</div>
                    <div class="stat-label">Booked</div>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-check-circle"></i>
                <div>
                    <div class="stat-number" id="completedCount">0</div>
                    <div class="stat-label">Completed</div>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-times-circle"></i>
                <div>
                    <div class="stat-number" id="cancelledCount">0</div>
                    <div class="stat-label">Cancelled</div>
                </div>
            </div>
        </div>

        <div class="filter-bar">
            <select id="statusFilter" class="filter-select">
                <option value="all">📋 All Status</option>
                <option value="Booked">🕐 Booked</option>
                <option value="Completed">✅ Completed</option>
                <option value="Cancelled">❌ Cancelled</option>
            </select>
            <input type="text" id="searchInput" class="search-input" placeholder="🔍 Search by patient or doctor name...">
        </div>

        <div class="appointments-grid" id="appointmentsGrid">
        <%
                while (rs.next()) {
                    hasAppointments = true;
                    totalCount++;
                    String status = rs.getString("status");
                    String statusClass = status.toLowerCase();
                    
                    if ("Booked".equalsIgnoreCase(status)) bookedCount++;
                    else if ("Completed".equalsIgnoreCase(status)) completedCount++;
                    else if ("Cancelled".equalsIgnoreCase(status)) cancelledCount++;
        %>
            <div class="appointment-card" 
                 data-status="<%= status %>"
                 data-patient="<%= rs.getString("patient_name").toLowerCase() %>"
                 data-doctor="<%= rs.getString("doctor_name").toLowerCase() %>">
                <div class="status-badge <%= statusClass %>">
                    <i class="<%= statusClass.equals("booked") ? "fas fa-clock" : (statusClass.equals("completed") ? "fas fa-check-circle" : "fas fa-times-circle") %>"></i>
                    <%= status %>
                </div>
                
                <div class="appointment-header">
                    <span class="appointment-id">
                        <i class="fas fa-hashtag"></i> ID: <%= rs.getInt("appt_id") %>
                    </span>
                </div>

                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-user-injured"></i> PATIENT DETAILS
                    </div>
                    <div class="info-row">
                        <i class="fas fa-user"></i>
                        <span class="label">Name:</span>
                        <span class="value"><%= rs.getString("patient_name") %></span>
                    </div>
                    <div class="info-row">
                        <i class="fas fa-envelope"></i>
                        <span class="label">Email:</span>
                        <span class="value"><%= rs.getString("patient_email") %></span>
                    </div>
                </div>

                <div class="section">
                    <div class="section-title">
                        <i class="fas fa-user-md"></i> DOCTOR DETAILS
                    </div>
                    <div class="info-row">
                        <i class="fas fa-stethoscope"></i>
                        <span class="label">Name:</span>
                        <span class="value doctor-name">Dr. <%= rs.getString("doctor_name") %></span>
                    </div>
                    <div class="info-row">
                        <i class="fas fa-heartbeat"></i>
                        <span class="label">Specialization:</span>
                        <span class="value"><%= rs.getString("doctor_specialization") %></span>
                    </div>
                </div>

                <div class="datetime-row">
                    <div class="datetime-item">
                        <i class="fas fa-calendar-day"></i>
                        <span><%= rs.getDate("appt_date") %></span>
                    </div>
                    <div class="datetime-item">
                        <i class="fas fa-clock"></i>
                        <span><%= rs.getString("appt_time") %></span>
                    </div>
                </div>
            </div>
        <%
                }
                
                if (!hasAppointments) {
        %>
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <h3>No Appointments Found</h3>
                <p>There are no appointments in the system yet.</p>
                <p style="font-size: 0.85rem; margin-top: 0.5rem;">Appointments will appear here once patients book consultations.</p>
            </div>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("<div class='empty-state'><i class='fas fa-exclamation-triangle'></i><h3>Error Loading Appointments</h3><p>" + e.getMessage() + "</p></div>");
            }
        %>
        </div>

        <script>
            // Update stats
            document.getElementById('totalCount').innerText = <%= totalCount %>;
            document.getElementById('bookedCount').innerText = <%= bookedCount %>;
            document.getElementById('completedCount').innerText = <%= completedCount %>;
            document.getElementById('cancelledCount').innerText = <%= cancelledCount %>;

            // Filter functionality
            const statusFilter = document.getElementById('statusFilter');
            const searchInput = document.getElementById('searchInput');
            const appointmentCards = document.querySelectorAll('.appointment-card');

            function filterAppointments() {
                const selectedStatus = statusFilter.value;
                const searchTerm = searchInput.value.toLowerCase();

                let visibleCount = 0;

                appointmentCards.forEach(card => {
                    const status = card.getAttribute('data-status');
                    const patientName = card.getAttribute('data-patient');
                    const doctorName = card.getAttribute('data-doctor');

                    const statusMatch = selectedStatus === 'all' || status === selectedStatus;
                    const searchMatch = searchTerm === '' || 
                                        patientName.includes(searchTerm) || 
                                        doctorName.includes(searchTerm);

                    if (statusMatch && searchMatch) {
                        card.style.display = '';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                // Show no results message
                const grid = document.getElementById('appointmentsGrid');
                const existingNoResults = document.querySelector('.no-results');
                
                if (visibleCount === 0 && appointmentCards.length > 0) {
                    if (!existingNoResults) {
                        const noResultsDiv = document.createElement('div');
                        noResultsDiv.className = 'no-results';
                        noResultsDiv.innerHTML = '<i class="fas fa-search"></i><p style="margin-top: 0.5rem;">No appointments match your filters</p>';
                        grid.appendChild(noResultsDiv);
                    } else {
                        existingNoResults.style.display = '';
                    }
                } else {
                    if (existingNoResults) {
                        existingNoResults.style.display = 'none';
                    }
                }
            }

            statusFilter.addEventListener('change', filterAppointments);
            searchInput.addEventListener('input', filterAppointments);
        </script>

        <div style="text-align: center;">
            <a href="adash.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
            </a>
        </div>
    </div>
</body>
</html>