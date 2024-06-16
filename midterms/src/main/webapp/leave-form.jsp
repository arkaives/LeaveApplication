<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Application</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        body {
            background: url('https://static.vecteezy.com/system/resources/previews/002/310/336/original/curve-background-3d-rendering-podium-platform-shape-purple-pastel-3d-stage-podium-product-on-3d-background-modern-vector.jpg') no-repeat center center fixed;
            background-size: cover;
            color: black;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* Prevents background from moving */
        }

        .header {
            background-color: #ffffff; /* White background for header */
            padding: 10px 20px; /* Padding for header */
            display: flex; /* Use flexbox for layout */
            justify-content: space-between; /* Space between elements */
            align-items: center; /* Align items vertically */
            position: fixed; /* Fixed position on top */
            width: 100%; /* Full width */
            top: 0; /* Position from top */
            z-index: 1000; /* Higher stacking order */
        }

        .header-title {
            display: flex; /* Use flexbox for title and link */
            align-items: center; /* Align items vertically */
        }

        .header-text {
            color: black; /* Black text color */
            font-size: 24px; /* Font size */
            font-weight: bold; /* Bold font weight */
        }

        .smaller-text {
            color: violet; /* Violet text color */
            font-size: 18px; /* Font size */
            cursor: pointer; /* Cursor pointer on hover */
            margin-left: 20px; /* Margin left for spacing */
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 80px; /* Adjust top margin to clear the fixed header */
            min-height: calc(100vh - 80px); /* Adjust for content below header */
        }

        .card {
            display: flex;
            flex-direction: row;
            width: 900px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            height: 525px;
            opacity: 0; /* Start with card hidden */
            transform: translateY(20px); /* Start card below final position */
            transition: opacity 0.5s ease, transform 0.5s ease; /* Smooth transition */
        }

        .card.loaded {
            opacity: 1; /* Show card when loaded class is added */
            transform: translateY(0); /* Slide card up */
        }

        .card img {
            max-width: 100%;
            height: auto;
            max-height: 525px;
            object-fit: cover;
        }

        .card-body {
            padding: 30px;
            background-color: white;
            flex: 1;
        }

        .form-control {
            background-color: #f7f7f7;
            color: #333;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-control:focus {
            background-color: #fff;
            color: #333;
            border: 1px solid #007bff;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.2);
        }

        .btn-primary {
            background-color: #8a2be2; /* Violet background color */
            border-color: #8a2be2; /* Matching border color */
            color: white; /* Text color */
            transition: background-color 0.3s, box-shadow 0.3s; /* Smooth transition */
            width: 100%; /* Make button full-width */
        }

        .btn-primary:hover {
            background-color: #6a1a9a; /* Darker violet on hover */
            box-shadow: 0 0 10px rgba(138, 43, 226, 0.8); /* Glow effect */
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            z-index: 1000;
            width: 100%
        }

        .dropdown:hover .dropdown-menu {
            display: block;
            animation: slide-down 0.3s ease-out;
        }

        @keyframes slide-down {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-title">
            <div class="header-text">Leave Application</div>
            <a href="<%=request.getContextPath()%>/leave-list" class="smaller-text">Leave List</a>
        </div>
    </div>

    <div class="container">
        <div class="card" id="card">
            <div>
                <img src="https://img.freepik.com/premium-photo/3d-illustration-cartoon-young-casual-man-floating-using-computer-laptop-working-from-home-online-education-learning-while-quarantine-from-virus-outbreak-covid-19_34439-644.jpg" alt="Sidebar Image">
            </div>
            <div class="card-body">
                <form action="<%=request.getContextPath()%>/leave-list?action=${leave != null ? 'update' : 'insert'}" method="post">
                    <h2 class="mb-4">
                        ${leave != null ? 'Edit Leave Application' : 'Apply for Leave'}
                    </h2>

                    <c:if test="${leave != null}">
                        <input type="hidden" name="id" value="${leave.id}" />
                    </c:if>

                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" value="${leave != null ? leave.name : ''}" class="form-control" name="name" required="required">
                    </div>

                    <div class="form-group">
                        <label>Leave Type</label>
                        <input type="hidden" id="leaveType" name="leaveType" value="${leave != null ? leave.leaveType : ''}">
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle form-control" type="button" id="leaveTypeDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <c:choose>
                                    <c:when test="${not empty leave && not empty leave.leaveType}">
                                        ${leave.leaveType}
                                    </c:when>
                                    <c:otherwise>
                                        Select Leave Type
                                    </c:otherwise>
                                </c:choose>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="leaveTypeDropdown">
                                <a class="dropdown-item" href="#" onclick="selectLeaveType('Maternity Leave')">Maternity Leave</a>
                                <a class="dropdown-item" href="#" onclick="selectLeaveType('Annual Leave')">Annual Leave</a>
                                <a class="dropdown-item" href="#" onclick="selectLeaveType('Sick Leave')">Sick Leave</a>
                                <a class="dropdown-item" href="#" onclick="selectLeaveType('Vacation Leave')">Vacation Leave</a>
                                <a class="dropdown-item" href="#" onclick="selectLeaveType('Casual Leave')">Casual Leave</a>
                                <a class="dropdown-item" href="#" onclick="selectLeaveType('Emergency Leave')">Emergency Leave</a>
                                <a class="dropdown-item" href="#" onclick="selectLeaveType('Half-day Leave')">Half-day Leave</a>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Status</label>
                        <input type="hidden" id="leaveStatus" name="status" value="${leave != null ? leave.status : ''}">
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle form-control" type="button" id="statusDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <c:choose>
                                    <c:when test="${not empty leave && not empty leave.status}">
                                        ${leave.status}
                                    </c:when>
                                    <c:otherwise>
                                        Select Status
                                    </c:otherwise>
                                </c:choose>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="statusDropdown">
                                <a class="dropdown-item" href="#" onclick="selectStatus('Pending')">Pending</a>
                                <a class="dropdown-item" href="#" onclick="selectStatus('Approved')">Approved</a>
                                <a class="dropdown-item" href="#" onclick="selectStatus('Rejected')">Rejected</a>
                                <a class="dropdown-item" href="#" onclick="selectStatus('Cancelled')">Cancelled</a>
                                <a class="dropdown-item" href="#" onclick="selectStatus('Expired')">Expired</a>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block glow">Submit</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Include jQuery, Popper.js, and Bootstrap JavaScript -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKpH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6HOG4SN78p3ylbihKHXK7Bq8cYI6Qxudv+Je0cwdy1qyl crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy68SRWfAiw1SB7AB/pibHhZJFv6BaNQKQF/6M" crossorigin="anonymous"></script>

    <script>
        // Function to slide up the card when page is loaded
        window.addEventListener('DOMContentLoaded', function() {
            var card = document.getElementById('card');
            card.classList.add('loaded'); // Add loaded class to trigger animation
        });
        
        function selectLeaveType(type) {
            document.getElementById('leaveType').value = type;
            document.getElementById('leaveTypeDropdown').innerText = type;
        }

        function selectStatus(status) {
            document.getElementById('leaveStatus').value =  status;
            document.getElementById('statusDropdown').innerText = status;
        }
    </script>
</body>
</html> 