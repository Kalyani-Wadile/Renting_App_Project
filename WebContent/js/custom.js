/**
 * 
 */
document.addEventListener("DOMContentLoaded", function() {
  const sideNavButton = document.getElementById('navToggleButton');
  const sideBar = document.querySelector('.sidebar');
  const dataContent = document.getElementById('data');
  console.log(sideNavButton);
  console.log(sideBar);
  console.log(dataContent);
  
 
  

  sideNavButton.addEventListener('click', function() {
    if (sideBar.classList.contains('collapsed-sidebar')) {
      sideBar.classList.remove('collapsed-sidebar');
      dataContent.classList.remove('shrinked');
      dataContent.classList.add('display-area');
    } else {
      sideBar.classList.add('collapsed-sidebar');
      dataContent.classList.remove('display-area');
      dataContent.classList.add('shrinked');
    }
  });
  
  
  // Get the search input element
  const searchInput = document.getElementById('searchInput');

  // Get the search form element
  const searchForm = document.getElementById('searchForm');

  // Function to submit the form and update search value
  function updateSearchValue() {
      const searchValue = searchInput.value.trim();
      // Set the search value as the value of the hidden input
      document.getElementById('referringPage').value = window.location.href;
      // Submit the form to the servlet
      searchForm.submit();
  }

  // Add event listener to the search form
  searchForm.addEventListener('submit', function(event) {
      event.preventDefault(); // Prevent default form submission
      updateSearchValue(); // Update search value and submit form
  });

  // Add event listener to the search button
  const searchButton = document.getElementById('searchButton');
  searchButton.addEventListener('click', function(event) {
      event.preventDefault(); // Prevent default button action
      updateSearchValue(); // Update search value and submit form
  });
  
  
  
});
