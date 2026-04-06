<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Doctors | Medix</title>
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
        .doctors-container {
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

        .stat-card .stat-number {
            font-size: 1.3rem;
            font-weight: 700;
            color: #0f172a;
        }

        .stat-card .stat-label {
            font-size: 0.8rem;
            color: #64748b;
        }

        /* Search Bar */
        .search-bar {
            margin-bottom: 2rem;
            display: flex;
            justify-content: center;
        }

        .search-input {
            width: 100%;
            max-width: 400px;
            padding: 0.875rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 40px;
            font-size: 0.9rem;
            font-family: 'Inter', sans-serif;
            background: white;
            transition: all 0.3s ease;
            padding-left: 2.5rem;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="%2394a3b8" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>');
            background-repeat: no-repeat;
            background-position: 1rem center;
        }

        .search-input:focus {
            outline: none;
            border-color: #1a6d5e;
            box-shadow: 0 0 0 3px rgba(26, 109, 94, 0.1);
        }

        /* Doctors Grid */
        .doctors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
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
            position: relative;
        }

        .doctor-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.15);
        }

        /* Doctor Header */
        .doctor-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.2rem;
        }

        .doctor-avatar {
            width: 70px;
            height: 70px;
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

        .doctor-info h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.25rem;
        }

        .doctor-id {
            font-size: 0.7rem;
            color: #64748b;
            background: #f1f5f9;
            padding: 0.2rem 0.6rem;
            border-radius: 40px;
            display: inline-block;
        }

        /* Doctor Details */
        .doctor-details {
            margin-bottom: 1.2rem;
            padding: 0.8rem 0;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
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
            width: 100px;
        }

        .detail-row .value {
            font-weight: 500;
            color: #0f172a;
            flex: 1;
        }

        .fees-badge {
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 40px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.8rem;
            margin-top: 1rem;
        }

        .btn-edit, .btn-delete {
            flex: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.7rem;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: #e0f2fe;
            color: #0369a1;
        }

        .btn-edit:hover {
            background: #0369a1;
            color: white;
            transform: translateY(-2px);
        }

        .btn-delete {
            background: #fee2e2;
            color: #dc2626;
        }

        .btn-delete:hover {
            background: #dc2626;
            color: white;
            transform: translateY(-2px);
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
            .doctors-container {
                margin: 1rem auto;
            }
            
            .doctors-grid {
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

        /* No results message */
        .no-results {
            text-align: center;
            padding: 2rem;
            color: #64748b;
            grid-column: 1/-1;
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>
    
    <div class="doctors-container">
        <div class="page-header">
            <h2><i class="fas fa-stethoscope"></i> Medical Staff Directory</h2>
            <p>View and manage all registered doctors</p>
        </div>

        <div class="stats-row" id="statsRow">
            <div class="stat-card">
                <i class="fas fa-user-md"></i>
                <div>
                    <div class="stat-number" id="totalDoctors">0</div>
                    <div class="stat-label">Total Doctors</div>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-heartbeat"></i>
                <div>
                    <div class="stat-number" id="specializations">0</div>
                    <div class="stat-label">Specializations</div>
                </div>
            </div>
        </div>

        <div class="search-bar">
            <input type="text" id="searchInput" class="search-input" placeholder="Search by name, specialization, or degree...">
        </div>

        <div class="doctors-grid" id="doctorsGrid">
            <%
                int doctorCount = 0;
                java.util.HashSet<String> specializationsSet = new java.util.HashSet<>();
                
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection(
                        "jdbc:oracle:thin:@localhost:1521:XE", "system", "SUMAN");

                    String q = "SELECT * FROM doctor ORDER BY id";
                    PreparedStatement ps = con.prepareStatement(q);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        doctorCount++;
                        specializationsSet.add(rs.getString("specialization"));
            %>
            <div class="doctor-card" data-name="<%= rs.getString("name").toLowerCase() %>" 
                                   data-specialization="<%= rs.getString("specialization").toLowerCase() %>"
                                   data-degree="<%= rs.getString("degree").toLowerCase() %>">
                <div class="doctor-header">
                    <div class="doctor-avatar">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <div class="doctor-info">
                        <h3>Dr. <%= rs.getString("name") %></h3>
                        <span class="doctor-id"><i class="fas fa-id-card"></i> ID: <%= rs.getString("id") %></span>
                    </div>
                </div>
                
                <div class="doctor-details">
                    <div class="detail-row">
                        <i class="fas fa-stethoscope"></i>
                        <span class="label">Specialization:</span>
                        <span class="value"><%= rs.getString("specialization") %></span>
                    </div>
                    <div class="detail-row">
                        <i class="fas fa-envelope"></i>
                        <span class="label">Email:</span>
                        <span class="value"><%= rs.getString("email") %></span>
                    </div>
                    <div class="detail-row">
                        <i class="fas fa-phone-alt"></i>
                        <span class="label">Phone:</span>
                        <span class="value"><%= rs.getString("phone") %></span>
                    </div>
                    <div class="detail-row">
                        <i class="fas fa-graduation-cap"></i>
                        <span class="label">Degree:</span>
                        <span class="value"><%= rs.getString("degree") %></span>
                    </div>
                    <div class="detail-row">
                        <i class="fas fa-rupee-sign"></i>
                        <span class="label">Consultation Fee:</span>
                        <span class="value"><span class="fees-badge">₹<%= rs.getString("fees") %></span></span>
                    </div>
                </div>
                
                <div class="action-buttons">
                    <a href="dedit.jsp?id=<%= rs.getString("id") %>" class="btn-edit">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="Ddelete?id=<%= rs.getString("id") %>" class="btn-delete" 
                       onclick="return confirm('⚠️ Are you sure you want to delete Dr. <%= rs.getString("name") %>?\n\nThis action cannot be undone.');">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </div>
            </div>
            <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<div class='empty-state'><i class='fas fa-exclamation-triangle'></i><h3>Error loading doctors</h3><p>" + e.getMessage() + "</p></div>");
                }
            %>
        </div>

        <script>
            // Update stats
            document.getElementById('totalDoctors').innerText = <%= doctorCount %>;
            document.getElementById('specializations').innerText = <%= specializationsSet.size() %>;

            // Search functionality
            const searchInput = document.getElementById('searchInput');
            const doctorCards = document.querySelectorAll('.doctor-card');

            function filterDoctors() {
                const searchTerm = searchInput.value.toLowerCase();
                let visibleCount = 0;

                doctorCards.forEach(card => {
                    const name = card.getAttribute('data-name') || '';
                    const specialization = card.getAttribute('data-specialization') || '';
                    const degree = card.getAttribute('data-degree') || '';
                    
                    if (name.includes(searchTerm) || specialization.includes(searchTerm) || degree.includes(searchTerm)) {
                        card.style.display = '';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                // Show no results message if needed
                const grid = document.getElementById('doctorsGrid');
                const existingNoResults = document.querySelector('.no-results');
                
                if (visibleCount === 0 && doctorCards.length > 0) {
                    if (!existingNoResults) {
                        const noResultsDiv = document.createElement('div');
                        noResultsDiv.className = 'no-results';
                        noResultsDiv.innerHTML = '<i class="fas fa-search"></i><p style="margin-top: 0.5rem;">No doctors found matching "<strong>' + searchTerm + '</strong>"</p>';
                        grid.appendChild(noResultsDiv);
                    } else {
                        existingNoResults.style.display = '';
                        existingNoResults.innerHTML = '<i class="fas fa-search"></i><p style="margin-top: 0.5rem;">No doctors found matching "<strong>' + searchTerm + '</strong>"</p>';
                    }
                } else {
                    if (existingNoResults) {
                        existingNoResults.style.display = 'none';
                    }
                }
            }

            searchInput.addEventListener('input', filterDoctors);
        </script>

        <div style="text-align: center;">
            <a href="adash.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>