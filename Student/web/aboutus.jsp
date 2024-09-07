<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BrightMind Institute</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .about-section {
            padding: 60px 0;
        }
        .about-section h2 {
            margin-bottom: 30px;
            font-size: 2.5rem;
            font-weight: bold;
        }
        .about-section p {
            font-size: 1.2rem;
            line-height: 1.6;
        }
        .team-member {
            margin-bottom: 30px;
        }
        .team-member img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
        .team-member h4 {
            margin-top: 10px;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">
            <img src="BrightMind2.png" alt="" style="height: 60px;">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact.jsp">Contact</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="aboutus.jsp">About Us</a>
                </li>
            </ul>
        </div>
    </nav>

    <header class="hero-section">
        <div class="container text-center">
            <h1>About Us</h1>
            <p>Learn more about our mission and vision</p>
        </div>
    </header>

    <section class="about-section text-center">
        <div class="container">
            <h2>Our Mission</h2>
            <p>At BrightMind Institute, our mission is to provide high-quality education and training to help students achieve their full potential. We are committed to fostering a supportive and innovative learning environment that prepares our students for success in their chosen fields.</p>
        </div>
    </section>

    <section class="about-section text-center bg-light">
        <div class="container">
            <h2>Our Vision</h2>
            <p>Our vision is to be a leading educational institution recognized for excellence in teaching, research, and community engagement. We aim to inspire and empower our students to become leaders and innovators in their professions.</p>
        </div>
    </section>

    

    <footer class="bg-light text-center py-3">
        <p>&copy; 2024 BrightMind Institute. All rights reserved.</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
