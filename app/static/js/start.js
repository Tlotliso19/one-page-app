// Get the navbar element
const navbar = document.getElementById('navbar');

// Function to change navbar color on scroll
function changeNavbarColorOnScroll() {
    if (window.scrollY > 50) {  // Adjust the scroll position to your preference
        navbar.classList.add('scrolled');  // Add class to change color
    } else {
        navbar.classList.remove('scrolled');  // Remove class to revert back
    }
}

// Add scroll event listener to call the function when scrolling
window.addEventListener('scroll', changeNavbarColorOnScroll);

// Initialize Swiper only if the screen width is 768px or smaller (for mobile devices)
document.addEventListener('DOMContentLoaded', function() {
    // Check if screen width is 768px or smaller (mobile devices)
    
    if (window.innerWidth <= 768) {
      console.log(window.innerWidth);
      const swiper = new Swiper('.swiper-container', {
        speed: 400,            // Speed of slide transition (in milliseconds)
        spaceBetween: 100,     // Space between slides (in pixels)
        loop: true,            // Infinite loop
        navigation: {
          nextEl: '.swiper-button-next',  // Next button
          prevEl: '.swiper-button-prev',  // Prev button
        },
        pagination: {
          el: '.swiper-pagination',  // Pagination controls
          clickable: true,           // Make the dots clickable
        },
      });
    }
  });  
  
