<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- Sidebar -->
<div class="sidebar collapsed-sidebar">
	<ul class="nav-list">
		<li class="nav-list-item">
		  <a href="home_1.jsp" class="nav-link">
			  <i class="fa-solid fa-house ifor" style="color: #ffffff;"></i>
			  <span>Dashboard</span>
		  </a>
		</li>
		<li class="nav-list-item">
			<a href="product_list.jsp" class="nav-link">
				<i class="fa-solid fa-shop ifor" style="color: #ffffff;"></i>
				<span>List Of Products</span>
			</a>
		</li>
		<li class="nav-list-item">
			<a href="product_add.jsp" class="nav-link">
				<i class="fas fa-plus-square ifor" style="color: #ffffff;"></i>
				<span>Add Product</span>
			</a>
		</li>
		<li class="nav-list-item">
			<a href="order_list.jsp" class="nav-link">
				<i class="fa-solid fa-cart-shopping ifor" style="color: #ffffff;"></i>
				<span>Orders</span>
			</a>
		</li>
		<li class="nav-list-item">
			<a href="request_message.jsp" class="nav-link">
				<i class="fa-solid fa-envelope ifor" style="color: #ffffff;"></i>
				<span>Product Request Msg</span>
			</a>
		</li>
		<li class="nav-list-item">
			<a href="product_nearme.jsp" class="nav-link">
				<i class="fa-solid fa-magnifying-glass ifor" style="color: #ffffff;"></i>
				<span>Nearby Search</span>
			</a>
		</li>
		<li class="nav-list-item">
			<a href="user_product.jsp" class="nav-link">
				<i class="fa-solid fa-store ifor" style="color: #ffffff;"></i>
				<span>My Products</span>
			</a>
		</li>
				<li class="nav-list-item">
			<a href="user_messages.jsp" class="nav-link">
				<i class="fa-solid fa-message ifor" style="color: #ffffff;"></i>
				<span>User Messages</span>
			</a>
		</li>
		<li class="nav-list-item">
			<a href="index.jsp" class="nav-link">
				<i class="fa-solid fa-right-to-bracket ifor" style="color: #ffffff;"></i>
				<span>Login</span>
			</a>
		</li>
		<li class="nav-list-item">
			<a href="LogoutUser" class="nav-link">
				<i class="fa-solid fa-right-from-bracket ifor" style="color: #ffffff;"></i>
				<span>Logout</span>
			</a>
		</li>	
		<li class="nav-list-item">
			<a href="user_delete.jsp" class="nav-link" onclick="return confirm('Are you sure you want to delete this Account?');">
				<i class="fa-solid fa-trash ifor" style="color: #ffffff;"></i>
				<span>Delete Account</span>
			</a>
		</li>	
	</ul>  
</div>