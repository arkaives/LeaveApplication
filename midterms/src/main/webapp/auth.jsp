<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Authentication</title>
    <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <style>
        body {
            background: url('https://static.vecteezy.com/system/resources/previews/005/434/213/large_2x/purple-product-background-stand-or-podium-pedestal-on-empty-display-with-purple-background-3d-rendering-free-photo.JPG') no-repeat center center fixed;
            background-size: cover;
            color: white;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            overflow: hidden; /* Prevents background from moving */
            margin: 0; /* Remove default margin */
        }

        .container {
            perspective: 1000px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            margin-top: -175px;
        }

        .card-container {
            position: relative;
            width: 400px;
            transform-style: preserve-3d;
            transition: transform 0.6s;
        }

        .card {
            position: absolute;
            width: 100%;
            backface-visibility: hidden;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
        }

        .card.front {
            background-color: white;
            color: black;
        }

        .card.back {
            background-color: black;
            color: white;
            transform: rotateY(180deg);
        }

        .card .form-control {
            background-color: inherit;
            color: inherit;
            border: 1px solid violet; /* Violet border */
        }

        .card .form-control:focus {
            background-color: inherit;
            color: violet; /* Violet text */
            border: 1px solid darkviolet; /* Dark violet border */
            box-shadow: 0 0 10px darkviolet; /* Darker violet shadow */
        }

        .card .btn-custom {
            background-color: violet;
            border-color: violet;
            color: white;
            transition: box-shadow 0.3s ease;
        }

        .card .btn-custom:hover {
            background-color: darkviolet; /* Dark violet background */
            border-color: darkviolet; /* Dark violet border */
            color: white;
            box-shadow: 0 0 10px darkviolet; /* Darker violet shadow */
        }

        .card .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        .card .text-center a {
            color: violet; /* Violet links */
            text-decoration: none;
        }

        .card .text-center a:hover {
            color: darkviolet; /* Dark violet on hover */
        }

        .card-container.flipped {
            transform: rotateY(180deg);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card-container" id="card-container">
            <div class="card front">
                <h2>Login</h2>
                <form action="auth" method="post">
                    <input type="hidden" name="action" value="login">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-custom btn-block">Login</button>
                    <% String loginError = (String) request.getAttribute("loginError"); %>
                    <% if (loginError != null && !loginError.isEmpty()) { %>
                        <p class="error-message"><%= loginError %></p>
                    <% } %>
                </form>
                <p class="text-center">Don't have an account? <a href="javascript:void(0);" onclick="flipCard()">Register here</a></p>
            </div>
            <div class="card back">
                <h2>Register</h2>
                <form action="auth" method="post">
                    <input type="hidden" name="action" value="register">
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-custom btn-block">Register</button>
                    <% String registerError = (String) request.getAttribute("registerError"); %>
                    <% if (registerError != null && !registerError.isEmpty()) { %>
                        <p class="error-message"><%= registerError %></p>
                    <% } %>
                </form>
                <p class="text-center">Already have an account? <a href="javascript:void(0);" onclick="flipCard()">Login here</a></p>
            </div>
        </div>
    </div>
    <script>
        function flipCard() {
            document.getElementById('card-container').classList.toggle('flipped');
        }
    </script>
</body>
</html>
