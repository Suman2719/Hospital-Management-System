<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- navbar.jsp -->
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    nav {
        background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
        padding: 0.875rem 2rem;
        display: flex;
        gap: 0.5rem;
        align-items: center;
        justify-content: center;
        flex-wrap: wrap;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(26, 109, 94, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    nav a {
        text-decoration: none;
        color: #334155;
        font-weight: 500;
        font-size: 0.95rem;
        padding: 0.625rem 1.25rem;
        border-radius: 40px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        letter-spacing: 0.3px;
        position: relative;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }

    /* Add icons to nav items */
    nav a:nth-child(1)::before {
        content: "🏠";
        font-size: 1rem;
    }
    nav a:nth-child(2)::before {
        content: "👤";
        font-size: 1rem;
    }
    nav a:nth-child(3)::before {
        content: "👨‍⚕️";
        font-size: 1rem;
    }
    nav a:nth-child(4)::before {
        content: "👑";
        font-size: 1rem;
    }
    nav a:nth-child(5)::before {
        content: "💊";
        font-size: 1rem;
    }
    nav a:nth-child(6)::before {
        content: "⚙️";
        font-size: 1rem;
    }

    nav a:hover {
        background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
        color: #ffffff;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(26, 109, 94, 0.3);
    }

    /* Active link indicator (optional - add 'active' class to current page) */
    nav a:active {
        transform: translateY(0);
    }

    /* Subtle underline animation on hover */
    nav a::after {
        content: '';
        position: absolute;
        bottom: 4px;
        left: 50%;
        width: 0;
        height: 2px;
        background: #ffffff;
        transition: all 0.3s ease;
        transform: translateX(-50%);
        border-radius: 2px;
    }

    nav a:hover::after {
        width: 30px;
    }

    hr {
        border: none;
        height: 1px;
        background: linear-gradient(90deg, transparent, #cbd5e1, #1a6d5e, #cbd5e1, transparent);
        margin: 0;
        width: 100%;
    }

    /* Mobile responsiveness */
    @media (max-width: 768px) {
        nav {
            padding: 0.75rem 1rem;
            gap: 0.25rem;
        }
        
        nav a {
            padding: 0.5rem 0.875rem;
            font-size: 0.85rem;
        }
        
        nav a::before {
            font-size: 0.9rem;
        }
    }

    @media (max-width: 640px) {
        nav {
            gap: 0.125rem;
        }
        
        nav a {
            padding: 0.5rem 0.7rem;
            font-size: 0.75rem;
        }
    }

    @media (max-width: 480px) {
        nav a span {
            display: none;
        }
        
        nav a::before {
            margin-right: 0;
        }
        
        nav a {
            padding: 0.5rem;
        }
    }

    /* Dark mode support (optional) */
    @media (prefers-color-scheme: dark) {
        nav {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        }
        
        nav a {
            color: #cbd5e1;
        }
        
        nav a:hover {
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: #ffffff;
        }
    }
</style>

<nav>
    <a href="login.jsp">Home</a>
    <a href="patientlogin.jsp">Patient</a>
    <a href="dlogin.jsp">Doctor</a>
    <a href="alogin.jsp">Admin</a>
    <a href="pharmacy.jsp">Pharmacy</a>
    <a href="services.jsp">Services</a>
</nav>
<hr>