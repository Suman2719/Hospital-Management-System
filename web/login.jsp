<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>MediTrack | Intelligent Healthcare System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Google Fonts + Font Awesome -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
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
            position: relative;
        }

        /* Hero Section with Stylish Heading */
        .hero-section {
            text-align: center;
            padding: 2.5rem 1rem 1rem;
        }

        /* Main MEDIX Heading - BIG & STYLISH */
        .medix-heading {
            font-size: 5.5rem;
            font-weight: 900;
            letter-spacing: -0.03em;
            background: linear-gradient(135deg, #1a6d5e 0%, #0f4c42 40%, #2d9c86 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            position: relative;
            display: inline-block;
            text-shadow: 0 2px 10px rgba(26, 109, 94, 0.2);
            animation: fadeInUp 0.8s ease-out;
        }

        /* Adding a stylish underline effect */
        .medix-heading::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 10%;
            width: 80%;
            height: 4px;
            background: linear-gradient(90deg, transparent, #1a6d5e, #2d9c86, #1a6d5e, transparent);
            border-radius: 4px;
        }

        /* Pulse animation for heartbeat icon */
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.7; }
            50% { transform: scale(1.1); opacity: 1; }
        }

        /* Icon beside heading */
        .heartbeat-icon {
            display: inline-block;
            animation: pulse 1.5s ease-in-out infinite;
            margin-right: 10px;
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            font-size: 5rem;
        }

        /* Subtitle styling */
        .tagline {
            font-size: 1.1rem;
            color: #5a6e7a;
            margin-top: 1.5rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        /* Fade In Animation */
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

        /* Carousel Container */
        .carousel-container {
            position: relative;
            max-width: 1300px;
            margin: 2rem auto;
            padding: 0 3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Arrow Buttons */
        .arrow {
            background: white;
            border: none;
            width: 48px;
            height: 48px;
            border-radius: 50%;
            font-size: 1.5rem;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            color: #1a6d5e;
            background: #ffffff;
            flex-shrink: 0;
        }

        .arrow:hover:not(:disabled) {
            background: #1a6d5e;
            color: white;
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(26, 109, 94, 0.3);
        }

        .arrow:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        /* Carousel */
        .carousel {
            display: flex;
            overflow-x: auto;
            scroll-behavior: smooth;
            gap: 1.8rem;
            padding: 1rem 0.5rem;
            scrollbar-width: thin;
            scrollbar-color: #1a6d5e #e2e8f0;
            flex: 1;
        }

        .carousel::-webkit-scrollbar {
            height: 6px;
        }

        .carousel::-webkit-scrollbar-track {
            background: #e2e8f0;
            border-radius: 10px;
        }

        .carousel::-webkit-scrollbar-thumb {
            background: #1a6d5e;
            border-radius: 10px;
        }

        /* Module Cards */
        .module-box {
            flex: 0 0 240px;
            background: white;
            border-radius: 28px;
            padding: 2rem 1rem 1.8rem;
            text-align: center;
            transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            cursor: pointer;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08), 0 8px 10px -6px rgba(0, 0, 0, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.5);
        }

        .module-box:hover {
            transform: translateY(-8px);
            box-shadow: 0 25px 40px -12px rgba(26, 109, 94, 0.25);
            border-color: #cbd5e1;
        }

        .module-box img {
            width: 85px;
            height: 85px;
            object-fit: contain;
            margin-bottom: 1.2rem;
            transition: transform 0.3s ease;
        }

        .module-box:hover img {
            transform: scale(1.05);
        }

        .module-box a {
            display: inline-block;
            text-decoration: none;
            background: linear-gradient(135deg, #1a6d5e 0%, #145c4f 100%);
            color: white;
            padding: 0.7rem 1.5rem;
            border-radius: 40px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            margin-top: 0.8rem;
            letter-spacing: 0.3px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .module-box a:hover {
            background: linear-gradient(135deg, #0f584b 0%, #0e4a3f 100%);
            transform: scale(0.98);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /* Footer */
        footer {
            background: #1a2a36;
            color: #a0b3c0;
            text-align: center;
            padding: 1.2rem;
            position: fixed;
            bottom: 0;
            width: 100%;
            font-size: 0.85rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            backdrop-filter: blur(4px);
            z-index: 10;
        }

        footer::before {
            content: 
            color: #e74c3c;
        }

        /* Decorative background */
        .bg-decoration {
            position: fixed;
            bottom: 0;
            right: 0;
            width: 300px;
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .medix-heading {
                font-size: 3.5rem;
            }
            .heartbeat-icon {
                font-size: 3.2rem;
            }
            .tagline {
                font-size: 0.9rem;
            }
            .carousel-container { 
                padding: 0 1rem; 
            }
            .module-box { 
                flex: 0 0 200px; 
                padding: 1.5rem 0.8rem; 
            }
            .module-box img { 
                width: 65px; 
                height: 65px; 
            }
            .arrow { 
                width: 40px; 
                height: 40px; 
                font-size: 1.2rem; 
            }
        }

        @media (max-width: 580px) {
            .medix-heading {
                font-size: 2.5rem;
            }
            .heartbeat-icon {
                font-size: 2.3rem;
            }
            .carousel { 
                gap: 1rem; 
            }
            .module-box { 
                flex: 0 0 170px; 
            }
            .module-box a { 
                padding: 0.5rem 1rem; 
                font-size: 0.8rem; 
            }
        }
    </style>
</head>
<body>

    <!-- Decorative element -->
    <div class="bg-decoration">
        <i class="fas fa-hospital-user" style="font-size: 250px;"></i>
    </div>

    <div class="hero-section">
        <div>
            <!-- Stylish BIG MEDIX Heading with heartbeat icon -->
            <i class="fas fa-heartbeat heartbeat-icon"></i>
            <span class="medix-heading">MEDIX</span>
        </div>
        <div class="tagline">
            <i class="fas fa-stethoscope" style="color: #1a6d5e; margin-right: 8px;"></i>
            Seamless Healthcare · Compassionate Technology
            <i class="fas fa-hand-holding-heart" style="color: #1a6d5e; margin-left: 8px;"></i>
        </div>
    </div>

    <div class="carousel-container">
        <!-- Left Arrow -->
        <button class="arrow left" onclick="scrollLeft()">&#10094;</button>

        <!-- Scrollable Box Container -->
        <div class="carousel" id="carousel">
            <div class="module-box">
                
                <a href="patientlogin.jsp">Patient Login</a>
            </div>

            <div class="module-box">
                
                <a href="dlogin.jsp">Doctor Login</a>
            </div>

            <div class="module-box">
                
                <a href="alogin.jsp">Admin Login</a>
            </div>

            <div class="module-box">
               
                <a href="pharmacy.jsp">Pharmacy</a>
            </div>

            <div class="module-box">
                
                <a href="services.jsp">Services</a>
            </div>
        </div>

        <!-- Right Arrow -->
        <button class="arrow right" onclick="scrollRight()">&#10095;</button>
    </div>

    <script>
        const carousel = document.getElementById("carousel");
        const leftBtn = document.querySelector(".arrow.left");
        const rightBtn = document.querySelector(".arrow.right");
        const STEP = 240; // pixels to move per click, adjust to match box width+gap

        // Smooth scroll with fallback
        function smoothScrollTo(el, left) {
            if ('scrollTo' in el) {
                try {
                    el.scrollTo({ left: left, behavior: 'smooth' });
                    return;
                } catch (e) { /* some older browsers throw */ }
            }
            // fallback
            el.scrollLeft = left;
        }

        function scrollLeft() {
            const newLeft = Math.max(0, carousel.scrollLeft - STEP);
            smoothScrollTo(carousel, newLeft);
        }

        function scrollRight() {
            const maxScroll = carousel.scrollWidth - carousel.clientWidth;
            const newLeft = Math.min(maxScroll, carousel.scrollLeft + STEP);
            smoothScrollTo(carousel, newLeft);
        }

        // enable/disable arrows based on scroll position
        function updateArrows() {
            const maxScroll = Math.max(0, carousel.scrollWidth - carousel.clientWidth);
            leftBtn.disabled = carousel.scrollLeft <= 0;
            rightBtn.disabled = carousel.scrollLeft >= maxScroll - 1;
            // small visual feedback
            leftBtn.style.opacity = leftBtn.disabled ? '0.5' : '1';
            rightBtn.style.opacity = rightBtn.disabled ? '0.5' : '1';
        }

        // Attach handlers
        leftBtn.addEventListener('click', scrollLeft);
        rightBtn.addEventListener('click', scrollRight);
        carousel.addEventListener('scroll', updateArrows);
        window.addEventListener('resize', updateArrows);

        // init
        window.addEventListener('load', updateArrows);
    </script>

    <footer>
        &copy; Medix 2025. All rights reserved | <i class="fas fa-heartbeat" style="color: #e74c3c;"></i> Your Health, Our Priority
    </footer>

</body>
</html>